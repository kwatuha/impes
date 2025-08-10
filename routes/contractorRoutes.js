const express = require('express');
const router = express.Router();
const multer = require('multer');
const pool = require('../config/db');

// Multer storage for contractor photos
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/contractor-photos/');
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});
const upload = multer({ storage: storage });

/**
 * @route GET /api/contractors
 * @description Get all active contractors.
 * @access Private (admin only)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_contractors WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching contractors:', error);
        res.status(500).json({ message: 'Error fetching contractors', error: error.message });
    }
});

/**
 * @route GET /api/contractors/:contractorId
 * @description Get a single contractor by ID.
 * @access Private (admin only)
 */
router.get('/:contractorId', async (req, res) => {
    const { contractorId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_contractors WHERE contractorId = ? AND voided = 0', [contractorId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Contractor not found.' });
        }
    } catch (error) {
        console.error('Error fetching contractor:', error);
        res.status(500).json({ message: 'Error fetching contractor', error: error.message });
    }
});

/**
 * @route POST /api/contractors
 * @description Create a new contractor.
 * @access Private (admin only)
 */
router.post('/', async (req, res) => {
    const { companyName, contactPerson, email, phone } = req.body;
    if (!companyName || !email) {
        return res.status(400).json({ message: 'Company name and email are required.' });
    }
    const newContractor = { companyName, contactPerson, email, phone };
    try {
        const [result] = await pool.query('INSERT INTO kemri_contractors SET ?', newContractor);
        res.status(201).json({ message: 'Contractor created', contractorId: result.insertId });
    } catch (error) {
        console.error('Error creating contractor:', error);
        res.status(500).json({ message: 'Error creating contractor', error: error.message });
    }
});

/**
 * @route PUT /api/contractors/:contractorId
 * @description Update an existing contractor.
 * @access Private (admin only)
 */
router.put('/:contractorId', async (req, res) => {
    const { contractorId } = req.params;
    const { companyName, contactPerson, email, phone } = req.body;
    const updatedFields = { companyName, contactPerson, email, phone };
    try {
        const [result] = await pool.query('UPDATE kemri_contractors SET ? WHERE contractorId = ? AND voided = 0', [updatedFields, contractorId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Contractor not found.' });
        }
        res.status(200).json({ message: 'Contractor updated successfully.' });
    } catch (error) {
        console.error('Error updating contractor:', error);
        res.status(500).json({ message: 'Error updating contractor', error: error.message });
    }
});

/**
 * @route DELETE /api/contractors/:contractorId
 * @description Soft-delete a contractor.
 * @access Private (admin only)
 */
router.delete('/:contractorId', async (req, res) => {
    const { contractorId } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_contractors SET voided = 1 WHERE contractorId = ? AND voided = 0', [contractorId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Contractor not found.' });
        }
        res.status(200).json({ message: 'Contractor soft-deleted successfully.' });
    } catch (error) {
        console.error('Error deleting contractor:', error);
        res.status(500).json({ message: 'Error deleting contractor', error: error.message });
    }
});

/**
 * @route GET /api/contractors/:contractorId/projects
 * @description Get all projects assigned to a specific contractor.
 * @access Private
 */
router.get('/:contractorId/projects', async (req, res) => {
    const { contractorId } = req.params;
    try {
        const [rows] = await pool.query(
            `SELECT p.* FROM kemri_projects p
             JOIN kemri_project_contractor_assignments pca ON p.id = pca.projectId
             WHERE pca.contractorId = ?`,
            [contractorId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching projects for contractor:', error);
        res.status(500).json({ message: 'Error fetching projects for contractor', error: error.message });
    }
});

/**
 * @route GET /api/contractors/:contractorId/payment-requests
 * @description Get all payment requests submitted by a specific contractor.
 * @access Private
 */
router.get('/:contractorId/payment-requests', async (req, res) => {
    const { contractorId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT * FROM kemri_project_payment_requests WHERE contractorId = ? ORDER BY submittedAt DESC',
            [contractorId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching payment requests for contractor:', error);
        res.status(500).json({ message: 'Error fetching payment requests for contractor', error: error.message });
    }
});

/**
 * @route POST /api/contractors/:contractorId/photos
 * @description A contractor uploads a new photo to a project.
 * @access Private
 */
router.post('/:contractorId/photos', upload.single('file'), async (req, res) => {
    const { contractorId } = req.params;
    const { projectId, caption } = req.body;
    const file = req.file;

    if (!file || !projectId) {
        return res.status(400).json({ message: 'File and projectId are required.' });
    }

    const newPhoto = {
        projectId,
        contractorId,
        filePath: file.path,
        caption: caption || `Photo submitted by contractor ${contractorId}`,
        status: 'Pending Review'
    };

    try {
        const [result] = await pool.query('INSERT INTO kemri_contractor_photos SET ?', newPhoto);
        res.status(201).json({ message: 'Photo uploaded successfully', photoId: result.insertId });
    } catch (error) {
        console.error('Error uploading contractor photo:', error);
        res.status(500).json({ message: 'Error uploading contractor photo', error: error.message });
    }
});

/**
 * @route GET /api/contractors/:contractorId/photos
 * @description Get all photos uploaded by a specific contractor.
 * @access Private
 */
// NEW: Add a GET route to fetch all photos by a contractor
router.get('/:contractorId/photos', async (req, res) => {
    const { contractorId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT * FROM kemri_contractor_photos WHERE contractorId = ? ORDER BY submittedAt DESC',
            [contractorId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching photos for contractor:', error);
        res.status(500).json({ message: 'Error fetching photos for contractor', error: error.message });
    }
});

module.exports = router;