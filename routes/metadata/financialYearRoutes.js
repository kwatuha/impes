// src/routes/metadata/financialYearRoutes.js

const express = require('express');
const router = express.Router();
const pool = require('../../config/db'); // Correct path for the new folder structure

// --- Financial Years CRUD ---

/**
 * @route GET /api/metadata/financialyears/
 * @description Get all financial years that are not soft-deleted.
 * @access Public (can be protected by middleware)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT finYearId, finYearName, startDate, endDate, createdAt, updatedAt, userId FROM kemri_financialyears WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching financial years:', error);
        res.status(500).json({ message: 'Error fetching financial years', error: error.message });
    }
});

/**
 * @route POST /api/metadata/financialyears/
 * @description Create a new financial year.
 * @access Private (requires authentication and privilege)
 */
router.post('/', async (req, res) => {
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now
    const { finYearName, startDate, endDate, remarks } = req.body;

    if (!finYearName || !startDate || !endDate) {
        return res.status(400).json({ message: 'Missing required fields: finYearName, startDate, endDate' });
    }

    try {
        const [result] = await pool.query(
            'INSERT INTO kemri_financialyears (finYearName, startDate, endDate, remarks, userId) VALUES (?, ?, ?, ?, ?)',
            [finYearName, startDate, endDate, remarks, userId]
        );
        res.status(201).json({ message: 'Financial year created successfully', finYearId: result.insertId });
    } catch (error) {
        console.error('Error creating financial year:', error);
        res.status(500).json({ message: 'Error creating financial year', error: error.message });
    }
});

/**
 * @route PUT /api/metadata/financialyears/:finYearId
 * @description Update an existing financial year by finYearId.
 * @access Private (requires authentication and privilege)
 */
router.put('/:finYearId', async (req, res) => {
    const { finYearId } = req.params;
    const { finYearName, startDate, endDate, remarks } = req.body;

    try {
        const [result] = await pool.query(
            'UPDATE kemri_financialyears SET finYearName = ?, startDate = ?, endDate = ?, remarks = ?, updatedAt = CURRENT_TIMESTAMP WHERE finYearId = ? AND voided = 0',
            [finYearName, startDate, endDate, remarks, finYearId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Financial year not found or already deleted' });
        }
        res.status(200).json({ message: 'Financial year updated successfully' });
    } catch (error) {
        console.error('Error updating financial year:', error);
        res.status(500).json({ message: 'Error updating financial year', error: error.message });
    }
});

/**
 * @route DELETE /api/metadata/financialyears/:finYearId
 * @description Soft delete a financial year by finYearId.
 * @access Private (requires authentication and privilege)
 */
router.delete('/:finYearId', async (req, res) => {
    const { finYearId } = req.params;
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now

    try {
        const [result] = await pool.query(
            'UPDATE kemri_financialyears SET voided = 1, voidedBy = ? WHERE finYearId = ? AND voided = 0',
            [userId, finYearId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Financial year not found or already deleted' });
        }
        res.status(200).json({ message: 'Financial year soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting financial year:', error);
        res.status(500).json({ message: 'Error deleting financial year', error: error.message });
    }
});

module.exports = router;