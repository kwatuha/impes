// backend/routes/projectDocumentsRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const auth = require('../middleware/authenticate');
const privilege = require('../middleware/privilegeMiddleware');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

// Main upload directory for all project documents
const baseUploadDir = path.join(__dirname, '..', '..', 'uploads');

// Ensure the base upload directory exists
if (!fs.existsSync(baseUploadDir)) {
    try {
        fs.mkdirSync(baseUploadDir, { recursive: true });
        console.log(`Created base upload directory: ${baseUploadDir}`);
    } catch (error) {
        console.error(`Error creating base upload directory: ${baseUploadDir}`, error);
    }
}

// Multer storage configuration for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        // Get the projectId and documentCategory from the request body
        const { projectId, documentCategory } = req.body;
        if (!projectId || !documentCategory) {
            return cb(new Error("Missing projectId or documentCategory in request body. Cannot save file."));
        }
        
        // Construct the specific upload directory for this request
        const projectUploadDir = path.join(baseUploadDir, 'projects', projectId.toString());
        const documentUploadDir = path.join(projectUploadDir, documentCategory);

        // Ensure the directory exists. Use recursive: true to create parent directories if needed.
        if (!fs.existsSync(documentUploadDir)) {
            fs.mkdirSync(documentUploadDir, { recursive: true });
        }
        cb(null, documentUploadDir);
    },
    filename: (req, file, cb) => {
        // Generate a unique filename while preserving the original file extension
        const fileExtension = path.extname(file.originalname);
        cb(null, `${uuidv4()}${fileExtension}`);
    }
});

const upload = multer({ storage });


// @route   POST /api/documents
// @desc    Upload documents and photos for a project.
// @access  Private (e.g., requires 'document.create' privilege)
router.post('/', auth, privilege(['document.create']), upload.array('documents'), async (req, res) => {
    const { projectId, milestoneId, requestId, documentType, documentCategory, description } = req.body;
    const userId = req.user.id;
    const files = req.files;

    if (!files || files.length === 0 || !projectId || !documentType || !documentCategory) {
        return res.status(400).json({ message: 'Missing files or required fields: projectId, documentType, and documentCategory.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        const documentValues = files.map(file => {
            const documentPath = path.relative(path.join(__dirname, '..', '..'), file.path);
            return [
                projectId, 
                milestoneId || null, 
                requestId || null,
                documentType, 
                documentCategory, 
                documentPath.replace(/\\/g, '/'), 
                description || null,
                userId, 
                0, // isProjectCover
                0, // voided
                new Date(), // createdAt
                new Date()  // updatedAt
            ];
        });

        await connection.query(
            `INSERT INTO kemri_project_documents (projectId, milestoneId, requestId, documentType, documentCategory, documentPath, description, userId, isProjectCover, voided, createdAt, updatedAt) VALUES ?`,
            [documentValues]
        );
        
        await connection.commit();
        res.status(201).json({ message: 'Documents uploaded successfully.' });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error uploading documents:', error);
        res.status(500).json({ message: 'Error uploading documents', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   GET /api/documents/project/:projectId
// @desc    Get all documents and photos for a specific project.
// @access  Private (e.g., requires 'document.read_all' or 'document.read_own' privilege)
router.get('/project/:projectId', auth, privilege(['document.read_all']), async (req, res) => {
    const { projectId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        const [rows] = await connection.query('SELECT * FROM kemri_project_documents WHERE projectId = ? AND voided = 0', [projectId]);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching project documents:', error);
        res.status(500).json({ message: 'Error fetching project documents', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   PUT /api/documents/:documentId
// @desc    Updates a document's details (e.g., description).
// @access  Private (requires 'document.update' privilege)
router.put('/:documentId', auth, privilege(['document.update']), async (req, res) => {
    const { documentId } = req.params;
    const { description } = req.body;
    let connection;

    if (!description) {
        return res.status(400).json({ message: 'Description is required for updating the document.' });
    }

    try {
        connection = await db.getConnection();
        await connection.query(
            'UPDATE kemri_project_documents SET description = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?',
            [description, documentId]
        );
        res.status(200).json({ message: 'Document updated successfully.' });
    } catch (error) {
        console.error('Error updating document:', error);
        res.status(500).json({ message: 'Error updating document', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   DELETE /api/documents/:documentId
// @desc    Performs a soft delete on a document.
// @access  Private (requires 'document.delete' privilege)
router.delete('/:documentId', auth, privilege(['document.delete']), async (req, res) => {
    const { documentId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        await connection.query(
            'UPDATE kemri_project_documents SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?',
            [documentId]
        );
        res.status(200).json({ message: 'Document deleted successfully.' });
    } catch (error) {
        console.error('Error deleting document:', error);
        res.status(500).json({ message: 'Error deleting document', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   PUT /api/documents/cover/:documentId
// @desc    Sets a specific photo as the project cover.
// @access  Private (requires 'project.update' privilege)
router.put('/cover/:documentId', auth, privilege(['project.update']), async (req, res) => {
    const { documentId } = req.params;
    const userId = req.user.id;
    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        // Get the projectId of the document to update
        const [doc] = await connection.query('SELECT projectId FROM kemri_project_documents WHERE id = ? AND voided = 0', [documentId]);
        if (doc.length === 0) {
            await connection.rollback();
            return res.status(404).json({ message: 'Document not found.' });
        }
        const projectId = doc[0].projectId;

        // Reset the cover status for all other photos for this project
        await connection.query('UPDATE kemri_project_documents SET isProjectCover = 0 WHERE projectId = ?', [projectId]);

        // Set the specified document as the new project cover
        await connection.query('UPDATE kemri_project_documents SET isProjectCover = 1 WHERE id = ?', [documentId]);
        
        await connection.commit();
        res.status(200).json({ message: 'Project cover photo updated successfully.' });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error setting project cover photo:', error);
        res.status(500).json({ message: 'Error setting project cover photo', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});

module.exports = router;
