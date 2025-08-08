// src/routes/metadata/countyRoutes.js

const express = require('express');
const router = express.Router();
const pool = require('../../config/db'); // Correct path for the new folder structure

// --- Counties CRUD ---

/**
 * @route GET /api/metadata/counties/
 * @description Get all counties that are not soft-deleted.
 * @access Public (can be protected by middleware)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT countyId, name, geoLat, geoLon, createdAt, updatedAt, userId FROM kemri_counties WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching counties:', error);
        res.status(500).json({ message: 'Error fetching counties', error: error.message });
    }
});

/**
 * @route GET /api/metadata/counties/:countyId
 * @description Get a single county by ID.
 * @access Public (can be protected by middleware)
 */
router.get('/:countyId', async (req, res) => {
    const { countyId } = req.params;
    try {
        const [rows] = await pool.query('SELECT countyId, name, geoLat, geoLon, createdAt, updatedAt, userId FROM kemri_counties WHERE countyId = ? AND voided = 0', [countyId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'County not found' });
        }
    } catch (error) {
        console.error('Error fetching county:', error);
        res.status(500).json({ message: 'Error fetching county', error: error.message });
    }
});

/**
 * @route POST /api/metadata/counties/
 * @description Create a new county.
 * @access Private (requires authentication and privilege)
 */
router.post('/', async (req, res) => {
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now
    const { name, geoLat, geoLon, remarks } = req.body;

    if (!name) {
        return res.status(400).json({ message: 'Missing required field: name' });
    }

    try {
        const [result] = await pool.query(
            'INSERT INTO kemri_counties (name, geoLat, geoLon, remarks, userId) VALUES (?, ?, ?, ?, ?)',
            [name, geoLat, geoLon, remarks, userId]
        );
        res.status(201).json({ message: 'County created successfully', countyId: result.insertId });
    } catch (error) {
        console.error('Error creating county:', error);
        res.status(500).json({ message: 'Error creating county', error: error.message });
    }
});

/**
 * @route PUT /api/metadata/counties/:countyId
 * @description Update an existing county by countyId.
 * @access Private (requires authentication and privilege)
 */
router.put('/:countyId', async (req, res) => {
    const { countyId } = req.params;
    const { name, geoLat, geoLon, remarks } = req.body;

    try {
        const [result] = await pool.query(
            'UPDATE kemri_counties SET name = ?, geoLat = ?, geoLon = ?, remarks = ?, updatedAt = CURRENT_TIMESTAMP WHERE countyId = ? AND voided = 0',
            [name, geoLat, geoLon, remarks, countyId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'County not found or already deleted' });
        }
        res.status(200).json({ message: 'County updated successfully' });
    } catch (error) {
        console.error('Error updating county:', error);
        res.status(500).json({ message: 'Error updating county', error: error.message });
    }
});

/**
 * @route DELETE /api/metadata/counties/:countyId
 * @description Soft delete a county by countyId.
 * @access Private (requires authentication and privilege)
 */
router.delete('/:countyId', async (req, res) => {
    const { countyId } = req.params;
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now

    try {
        const [result] = await pool.query(
            'UPDATE kemri_counties SET voided = 1, voidedBy = ? WHERE countyId = ? AND voided = 0',
            [userId, countyId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'County not found or already deleted' });
        }
        res.status(200).json({ message: 'County soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting county:', error);
        res.status(500).json({ message: 'Error deleting county', error: error.message });
    }
});

// --- Hierarchical Routes ---

/**
 * @route GET /api/metadata/counties/:countyId/subcounties
 * @description Get all sub-counties belonging to a specific county.
 * @access Public (can be protected by middleware)
 */
router.get('/:countyId/subcounties', async (req, res) => {
    const { countyId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT subcountyId, name, geoLat, geoLon FROM kemri_subcounties WHERE countyId = ? AND voided = 0',
            [countyId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching sub-counties for county ${countyId}:`, error);
        res.status(500).json({ message: `Error fetching sub-counties for county ${countyId}`, error: error.message });
    }
});

module.exports = router;