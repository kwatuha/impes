// src/routes/milestoneRoutes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool

// --- REMOVE camelToSnakeCase and snakeToCamelCase helpers from this file ---
// Since your DB uses camelCase for columns, no conversion is needed for data objects.
// If you use these helpers elsewhere (e.g. for API response normalization for other tables),
// they should remain in a utility file, but not be applied here.

/**
 * @route GET /api/milestones
 * @description Get all milestones from the kemri_milestones table.
 */
router.get('/', async (req, res) => {
    try {
        // No conversion needed, as DB returns camelCase, which frontend expects
        const [rows] = await pool.query('SELECT * FROM kemri_milestones');
        res.status(200).json(rows); // Return directly
    } catch (error) {
        console.error('Error fetching all milestones:', error);
        res.status(500).json({ message: 'Error fetching all milestones', error: error.message });
    }
});

/**
 * @route GET /api/milestones/project/:projectId
 * @description Get all milestones for a specific project from the kemri_milestones table.
 */
router.get('/project/:projectId', async (req, res) => {
    const { projectId } = req.params; // projectId is camelCase from URL
    try {
        // Use projectId (camelCase) for the database column, as per your schema
        const [rows] = await pool.query('SELECT * FROM kemri_milestones WHERE projectId = ?', [projectId]);
        res.status(200).json(rows); // Return directly
    } catch (error) {
        console.error(`Error fetching milestones for project ${projectId}:`, error);
        res.status(500).json({ message: `Error fetching milestones for project ${projectId}`, error: error.message });
    }
});

/**
 * @route GET /api/milestones/:milestoneId
 * @description Get a single milestone by milestoneId from the kemri_milestones table.
 */
router.get('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params; // milestoneId is camelCase from URL
    try {
        // Use milestoneId (camelCase) for the database column, as per your schema
        const [rows] = await pool.query('SELECT * FROM kemri_milestones WHERE milestoneId = ?', [milestoneId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]); // Return directly
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
 * @description Create a new milestone in the kemri_milestones table.
 */
router.post('/', async (req, res) => {
    // req.body already contains camelCase from frontend (milestoneName, dueDate, completedDate, projectId)
    const clientData = req.body;

    // IMPORTANT: Assuming 'milestoneId' is AUTO_INCREMENT in your DB and should NOT be provided here
    // If you need to generate a client-side UUID, you'd add:
    // milestoneId: clientData.milestoneId || `m${Date.now()}-${Math.random().toString(36).substring(2, 9)}`,
    // But since your DB is AUTO_INCREMENT, we let the DB handle it.
    
    const newMilestone = {
        createdAt: new Date(), // Use camelCase as per DB schema
        updatedAt: new Date(), // Use camelCase as per DB schema
        ...clientData // This brings in milestoneName, milestoneDescription, dueDate, completed, completedDate, projectId
    };

    // Remove any client-provided milestoneId if the DB auto-increments it,
    // to avoid "Cannot add value to AUTO_INCREMENT column" errors.
    delete newMilestone.milestoneId; 

    try {
        console.log('Inserting Milestone:', newMilestone); // Log data going to DB
        // Query will map camelCase keys in newMilestone directly to camelCase DB columns
        const [result] = await pool.query('INSERT INTO kemri_milestones SET ?', newMilestone);
        
        // If the DB auto-generates milestoneId, capture it for the response
        if (result.insertId) {
            newMilestone.milestoneId = result.insertId;
        }

        res.status(201).json(newMilestone); // Return the created milestone as camelCase
    } catch (error) {
        console.error('Error creating milestone:', error);
        res.status(500).json({ message: 'Error creating milestone', error: error.message });
    }
});

/**
 * @route PUT /api/milestones/:milestoneId
 * @description Update an existing milestone in the kemri_milestones table.
 */
router.put('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params; // milestoneId is camelCase from URL
    const updatedFields = { 
        ...req.body, 
        updatedAt: new Date() // Use camelCase as per DB schema
    };

    // Remove milestoneId from the body to prevent attempting to update primary key
    delete updatedFields.milestoneId; 

    try {
        console.log(`Updating Milestone ${milestoneId}:`, updatedFields); // Log data going to DB
        // Query will map camelCase keys in updatedFields directly to camelCase DB columns
        const [result] = await pool.query('UPDATE kemri_milestones SET ? WHERE milestoneId = ?', [updatedFields, milestoneId]);
        
        if (result.affectedRows > 0) {
            // Fetch and return the updated row as camelCase
            const [rows] = await pool.query('SELECT * FROM kemri_milestones WHERE milestoneId = ?', [milestoneId]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Milestone not found' });
        }
    } catch (error) {
        console.error('Error updating milestone:', error);
        res.status(500).json({ message: 'Error updating milestone', error: error.message });
    }
});

/**
 * @route DELETE /api/milestones/:milestoneId
 * @description Delete a milestone from the kemri_milestones table.
 */
router.delete('/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params; // milestoneId is camelCase from URL
    try {
        // Use milestoneId (camelCase) for the database column
        const [result] = await pool.query('DELETE FROM kemri_milestones WHERE milestoneId = ?', [milestoneId]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Milestone not found' });
        }
    } catch (error) {
        console.error(`Error deleting milestone with ID ${milestoneId}:`, error);
        res.status(500).json({ message: `Error deleting milestone with ID ${milestoneId}`, error: error.message });
    }
});

module.exports = router;