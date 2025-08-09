const express = require('express');
const projectRouter = express.Router({ mergeParams: true });
const photoRouter = express.Router();
const multer = require('multer');
const pool = require('../config/db');

// Multer storage configuration for project photos
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/project-photos/');
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const upload = multer({ storage: storage });

// ------------------------------------------------
// --- Routes using :projectId (mounted as a sub-router) ---
// ------------------------------------------------

/**
 * @route GET /api/projects/:projectId/photos
 * @description Get all active photos for a specific project.
 * @access Private
 */
projectRouter.get('/', async (req, res) => {
    const { projectId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT * FROM kemri_project_photos WHERE projectId = ? AND voided = 0',
            [projectId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching project photos:', error);
        res.status(500).json({ message: 'Error fetching project photos', error: error.message });
    }
});

/**
 * @route POST /api/projects/:projectId/photos
 * @description Upload a new photo for a project.
 * @access Private
 */
projectRouter.post('/', upload.single('file'), async (req, res) => {
    const { projectId } = req.params;
    const file = req.file;

    if (!file) {
        return res.status(400).json({ message: 'No file uploaded.' });
    }

    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1;

    try {
        const newPhoto = {
            projectId,
            fileName: file.originalname,
            filePath: file.path,
            fileType: file.mimetype,
            fileSize: file.size,
            description: req.body.description || `Photo for project ${projectId}`,
            userId,
        };

        const [result] = await pool.query('INSERT INTO kemri_project_photos SET ?', newPhoto);
        const [rows] = await pool.query('SELECT * FROM kemri_project_photos WHERE photoId = ?', [result.insertId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error uploading project photo:', error);
        res.status(500).json({ message: 'Error uploading project photo', error: error.message });
    }
});

// ------------------------------------------------
// --- Routes using :photoId (mounted separately) ---
// ------------------------------------------------

/**
 * @route PUT /api/project_photos/:photoId/default
 * @description Sets a photo as the default for its project.
 * @access Private
 */
photoRouter.put('/:photoId/default', async (req, res) => {
    const { photoId } = req.params;
console.log('dddddddddddddddddddddd',req)
    // TODO: Get userId from authenticated user
    const userId = 1;

    const connection = await pool.getConnection();
    try {
        await connection.beginTransaction();

        // 1. Get the projectId from the photo being set as default
        const [photoRows] = await connection.query('SELECT projectId FROM kemri_project_photos WHERE photoId = ? AND voided = 0', [photoId]);
        if (photoRows.length === 0) {
            await connection.rollback();
            return res.status(404).json({ message: 'Photo not found.' });
        }
        const { projectId } = photoRows[0];

        // 2. Unset the current default photo for this project
        await connection.query('UPDATE kemri_project_photos SET isDefault = 0 WHERE projectId = ? AND isDefault = 1', [projectId]);

        // 3. Set the new photo as default
        await connection.query('UPDATE kemri_project_photos SET isDefault = 1 WHERE photoId = ?', [photoId]);

        // 4. Update the defaultPhotoId in the projects table
        await connection.query('UPDATE kemri_projects SET defaultPhotoId = ? WHERE id = ?', [photoId, projectId]);

        await connection.commit();
        res.status(200).json({ message: 'Default photo updated successfully.' });
    } catch (error) {
        await connection.rollback();
        console.error('Error setting default project photo:', error);
        res.status(500).json({ message: 'Error setting default project photo', error: error.message });
    } finally {
        connection.release();
    }
});

/**
 * @route DELETE /api/project_photos/:photoId
 * @description Soft-delete a project photo.
 * @access Private
 */
photoRouter.delete('/:photoId', async (req, res) => {
    const { photoId } = req.params;

    // TODO: Get userId from authenticated user
    const userId = 1;

    try {
        const [result] = await pool.query(
            'UPDATE kemri_project_photos SET voided = 1, voidedBy = ? WHERE photoId = ? AND voided = 0',
            [userId, photoId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Photo not found or already deleted' });
        }
        res.status(200).json({ message: 'Project photo soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting project photo:', error);
        res.status(500).json({ message: 'Error deleting project photo', error: error.message });
    }
});

// Export both routers to be mounted in app.js
module.exports = { projectRouter, photoRouter };