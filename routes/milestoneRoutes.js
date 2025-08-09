const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool

// --- Milestone Management API Calls (kemri_project_milestones) ---

/**
 * @route GET /api/milestones
 * @description Get all active milestones from the kemri_project_milestones table.
 * @access Private (protected by middleware)
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_milestones WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching all milestones:', error);
        res.status(500).json({ message: 'Error fetching all milestones', error: error.message });
    }
});

/**
 * @route GET /api/milestones/project/:projectId
 * @description Get all active milestones for a specific project.
 * @access Private (protected by middleware)
 */
router.get('/project/:projectId', async (req, res) => {
    const { projectId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_milestones WHERE projectId = ? AND voided = 0 ORDER BY sequenceOrder', [projectId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching milestones for project ${projectId}:`, error);
        res.status(500).json({ message: `Error fetching milestones for project ${projectId}`, error: error.message });
    }
});

/**
 * @route GET /api/milestones/:milestoneId
 * @description Get a single active milestone by milestoneId.
 * @access Private (protected by middleware)
 */
router.get('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_milestones WHERE milestoneId = ? AND voided = 0', [milestoneId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Milestone not found' });
        }
    } catch (error) {
        console.error('Error fetching milestone:', error);
        res.status(500).json({ message: 'Error fetching milestone', error: error.message });
    }
});

/**
 * @route POST /api/milestones
 * @description Create a new milestone.
 * @access Private (requires authentication and privilege)
 */
router.post('/', async (req, res) => {
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now
    const { projectId, milestoneName, milestoneDescription, dueDate, completed, completedDate, sequenceOrder } = req.body;
    
    // Ensure `completed` is a boolean, and `completedDate` is set if `completed` is true
    const isCompleted = completed ? 1 : 0;
    const completionDate = completed ? (completedDate || new Date()) : null;

    if (!projectId || !milestoneName || !dueDate) {
        return res.status(400).json({ message: 'Missing required fields: projectId, milestoneName, dueDate' });
    }
    
    const newMilestone = {
        projectId,
        milestoneName,
        milestoneDescription,
        dueDate,
        completed: isCompleted,
        completedDate: completionDate,
        sequenceOrder,
        userId,
        createdAt: new Date(),
        updatedAt: new Date(),
        voided: 0,
    };

    try {
        const [result] = await pool.query('INSERT INTO kemri_project_milestones SET ?', newMilestone);
        const [rows] = await pool.query('SELECT * FROM kemri_project_milestones WHERE milestoneId = ?', [result.insertId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating milestone:', error);
        res.status(500).json({ message: 'Error creating milestone', error: error.message });
    }
});

/**
 * @route PUT /api/milestones/:milestoneId
 * @description Update an existing milestone.
 * @access Private (requires authentication and privilege)
 */
router.put('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params;
    const { projectId, milestoneName, milestoneDescription, dueDate, completed, completedDate, sequenceOrder } = req.body;
    
    const isCompleted = completed ? 1 : 0;
    const completionDate = completed ? (completedDate || new Date()) : null;
    
    const updatedFields = {
        milestoneName,
        milestoneDescription,
        dueDate,
        completed: isCompleted,
        completedDate: completionDate,
        sequenceOrder,
        updatedAt: new Date(),
    };

    try {
        const [result] = await pool.query('UPDATE kemri_project_milestones SET ? WHERE milestoneId = ? AND voided = 0', [updatedFields, milestoneId]);
        
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_project_milestones WHERE milestoneId = ?', [milestoneId]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Milestone not found or already deleted' });
        }
    } catch (error) {
        console.error('Error updating milestone:', error);
        res.status(500).json({ message: 'Error updating milestone', error: error.message });
    }
});

/**
 * @route DELETE /api/milestones/:milestoneId
 * @description Soft delete a milestone.
 * @access Private (requires authentication and privilege)
 */
router.delete('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params;
    // TODO: Get userId from authenticated user (e.g., req.user.userId)
    const userId = 1; // Placeholder for now

    try {
        const [result] = await pool.query(
            'UPDATE kemri_project_milestones SET voided = 1, voidedBy = ? WHERE milestoneId = ? AND voided = 0',
            [userId, milestoneId]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Milestone not found or already deleted' });
        }
        res.status(200).json({ message: 'Milestone soft-deleted successfully' });
    } catch (error) {
        console.error('Error deleting milestone:', error);
        res.status(500).json({ message: 'Error deleting milestone', error: error.message });
    }
});

module.exports = router;