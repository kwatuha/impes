// src/routes/metadata/wardRoutes.js

const express = require('express');
const router = express.Router();
const pool = require('../../config/db'); // Correct path for the new folder structure

// --- Wards CRUD ---

/**
 * @route GET /api/metadata/wards/
 * @description Get all wards that are not soft-deleted.
 * @access Public (can be protected by middleware)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT wardId, name, subcountyId, geoLat, geoLon, createdAt, updatedAt, userId FROM kemri_wards WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching wards:', error);
        res.status(500).json({ message: 'Error fetching wards', error: error.message });
    }
});

/**
 * @route GET /api/metadata/wards/:wardId
 * @description Get a single ward by ID.
 * @access Public (can be protected by middleware)
 */
router.get('/:wardId', async (req, res) => {
    const { wardId } = req.params;
    try {
        const [rows] = await pool.query('SELECT wardId, name, subcountyId, geoLat, geoLon, createdAt, updatedAt, userId FROM kemri_wards WHERE wardId = ? AND voided = 0', [wardId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Ward not found' });
        }
    } catch (error) {
        console.error('Error fetching ward:', error);
        res.status(500).json({ message: 'Error fetching ward', error: error.message });
    }
});

/**
 * @route POST /api/metadata/wards/
 * @description Create a new ward.
 * @access Private (requires authentication and privilege)
 */
router.post('/', async (req, res) => {
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now
    const { name, subcountyId, geoLat, geoLon, remarks } = req.body;

    if (!name || !subcountyId) {
        return res.status(400).json({ message: 'Missing required fields: name, subcountyId' });
    }

    try {
        const [result] = await pool.query(
            'INSERT INTO kemri_wards (name, subcountyId, geoLat, geoLon, remarks, userId) VALUES (?, ?, ?, ?, ?, ?)',
            [name, subcountyId, geoLat, geoLon, remarks, userId]
        );
        res.status(201).json({ message: 'Ward created successfully', wardId: result.insertId });
    } catch (error) {
        console.error('Error creating ward:', error);
        res.status(500).json({ message: 'Error creating ward', error: error.message });
    }
});

/**
 * @route PUT /api/metadata/wards/:wardId
 * @description Update an existing ward by wardId.
 * @access Private (requires authentication and privilege)
 */
router.put('/:wardId', async (req, res) => {
    const { wardId } = req.params;
    const { name, subcountyId, geoLat, geoLon, remarks } = req.body;

    try {
        const [result] = await pool.query(
            'UPDATE kemri_wards SET name = ?, subcountyId = ?, geoLat = ?, geoLon = ?, remarks = ?, updatedAt = CURRENT_TIMESTAMP WHERE wardId = ? AND voided = 0',
            [name, subcountyId, geoLat, geoLon, remarks, wardId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Ward not found or already deleted' });
        }
        res.status(200).json({ message: 'Ward updated successfully' });
    } catch (error) {
        console.error('Error updating ward:', error);
        res.status(500).json({ message: 'Error updating ward', error: error.message });
    }
});

/**
 * @route DELETE /api/metadata/wards/:wardId
 * @description Soft delete a ward by wardId.
 * @access Private (requires authentication and privilege)
 */
router.delete('/:wardId', async (req, res) => {
    const { wardId } = req.params;
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now

    try {
        const [result] = await pool.query(
            'UPDATE kemri_wards SET voided = 1, voidedBy = ? WHERE wardId = ? AND voided = 0',
            [userId, wardId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Ward not found or already deleted' });
        }
        res.status(200).json({ message: 'Ward soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting ward:', error);
        res.status(500).json({ message: 'Error deleting ward', error: error.message });
    }
});

module.exports = router;