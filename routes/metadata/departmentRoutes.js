// src/routes/metadata/departmentRoutes.js

const express = require('express');
const router = express.Router();
const pool = require('../../config/db'); // Correct path for the new folder structure

// --- Departments CRUD ---

/**
 * @route GET /api/metadata/departments/
 * @description Get all departments that are not soft-deleted.
 * @access Public (can be protected by middleware)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT departmentId, name, alias, location, createdAt, updatedAt, userId FROM kemri_departments WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching departments:', error);
        res.status(500).json({ message: 'Error fetching departments', error: error.message });
    }
});

/**
 * @route POST /api/metadata/departments/
 * @description Create a new department.
 * @access Private (requires authentication and privilege)
 */
router.post('/', async (req, res) => {
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now
    const { name, alias, location, address, contactPerson, phoneNumber, email, remarks } = req.body;

    if (!name || !alias) {
        return res.status(400).json({ message: 'Missing required fields: name, alias' });
    }

    try {
        // CORRECTED: Explicitly set voided = 0 on creation
        const [result] = await pool.query(
            'INSERT INTO kemri_departments (name, alias, location, address, contactPerson, phoneNumber, email, remarks, userId, voided) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0)',
            [name, alias, location, address, contactPerson, phoneNumber, email, remarks, userId]
        );
        res.status(201).json({ message: 'Department created successfully', departmentId: result.insertId });
    } catch (error) {
        console.error('Error creating department:', error);
        res.status(500).json({ message: 'Error creating department', error: error.message });
    }
});

/**
 * @route PUT /api/metadata/departments/:departmentId
 * @description Update an existing department by departmentId.
 * @access Private (requires authentication and privilege)
 */
router.put('/:departmentId', async (req, res) => {
    const { departmentId } = req.params;
    // CORRECTED: Only get fields that should be updated. Exclude 'voided'.
    const { name, alias, location, address, contactPerson, phoneNumber, email, remarks } = req.body;
    const updatedFields = { name, alias, location, address, contactPerson, phoneNumber, email, remarks };

    try {
        const [result] = await pool.query(
            'UPDATE kemri_departments SET ? , updatedAt = CURRENT_TIMESTAMP WHERE departmentId = ? AND voided = 0',
            [updatedFields, departmentId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Department not found or already deleted' });
        }
        res.status(200).json({ message: 'Department updated successfully' });
    } catch (error) {
        console.error('Error updating department:', error);
        res.status(500).json({ message: 'Error updating department', error: error.message });
    }
});

/**
 * @route DELETE /api/metadata/departments/:departmentId
 * @description Soft delete a department by departmentId.
 * @access Private (requires authentication and privilege)
 */
router.delete('/:departmentId', async (req, res) => {
    const { departmentId } = req.params;
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now

    try {
        const [result] = await pool.query(
            'UPDATE kemri_departments SET voided = 1, voidedBy = ? WHERE departmentId = ? AND voided = 0',
            [userId, departmentId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Department not found or already deleted' });
        }
        res.status(200).json({ message: 'Department soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting department:', error);
        res.status(500).json({ message: 'Error deleting department', error: error.message });
    }
});

// --- Hierarchical Routes ---

/**
 * @route GET /api/metadata/departments/:departmentId/sections
 * @description Get all sections belonging to a specific department.
 * @access Public (can be protected by middleware)
 */
router.get('/:departmentId/sections', async (req, res) => {
    const { departmentId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT sectionId, name FROM kemri_sections WHERE departmentId = ? AND voided = 0',
            [departmentId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching sections for department ${departmentId}:`, error);
        res.status(500).json({ message: `Error fetching sections for department ${departmentId}`, error: error.message });
    }
});

module.exports = router;