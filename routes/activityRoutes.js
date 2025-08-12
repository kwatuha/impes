// src/routes/activityRoutes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool

// --- Helper Function: Format Date for MySQL DATE column ---
const formatToMySQLDate = (date) => {
    if (!date) return null;
    const d = new Date(date);
    if (isNaN(d.getTime())) {
        console.warn('Invalid date provided to formatToMySQLDate:', date);
        return null;
    }
    const year = d.getFullYear();
    const month = (d.getMonth() + 1).toString().padStart(2, '0');
    const day = d.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
};

// --- Helper Function: Format Date for MySQL DATETIME column ---
const formatToMySQLDateTime = (date) => {
    if (!date) return null;
    const d = new Date(date);
    if (isNaN(d.getTime())) {
        console.warn('Invalid date provided to formatToMySQLDateTime:', date);
        return null;
    }
    const year = d.getFullYear();
    const month = (d.getMonth() + 1).toString().padStart(2, '0');
    const day = d.getDate().toString().padStart(2, '0');
    const hours = d.getHours().toString().padStart(2, '0');
    const minutes = d.getMinutes().toString().padStart(2, '0');
    const seconds = d.getSeconds().toString().padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};

// GET all activities for a specific work plan
router.get('/by-workplan/:workplanId', async (req, res) => {
    const { workplanId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_activities WHERE workplanId = ? AND voided = 0', [workplanId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching activities:', error);
        res.status(500).json({ message: 'Error fetching activities', error: error.message });
    }
});

// GET a single activity by ID
router.get('/:activityId', async (req, res) => {
    const { activityId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_activities WHERE activityId = ? AND voided = 0', [activityId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Activity not found' });
        }
    } catch (error) {
        console.error('Error fetching activity:', error);
        res.status(500).json({ message: 'Error fetching activity', error: error.message });
    }
});

// POST a new activity
router.post('/', async (req, res) => {
    const newActivity = {
        ...req.body,
        // CORRECTED: Format date fields
        startDate: formatToMySQLDate(req.body.startDate),
        endDate: formatToMySQLDate(req.body.endDate),
        voided: 0,
        createdAt: formatToMySQLDateTime(new Date()),
        updatedAt: formatToMySQLDateTime(new Date()),
    };
    delete newActivity.activityId;

    try {
        console.log('Inserting Activity:', newActivity);
        const [result] = await pool.query('INSERT INTO kemri_activities SET ?', newActivity);
        if (result.insertId) {
            newActivity.activityId = result.insertId;
        }
        res.status(201).json(newActivity);
    } catch (error) {
        console.error('Error creating activity:', error);
        res.status(500).json({ message: 'Error creating activity', error: error.message });
    }
});

// PUT an existing activity
router.put('/:activityId', async (req, res) => {
    const { activityId } = req.params;
    const updatedFields = {
        ...req.body,
        // CORRECTED: Format date fields if they exist
        startDate: req.body.startDate ? formatToMySQLDate(req.body.startDate) : undefined,
        endDate: req.body.endDate ? formatToMySQLDate(req.body.endDate) : undefined,
        updatedAt: formatToMySQLDateTime(new Date()),
    };
    delete updatedFields.activityId;
    delete updatedFields.voided;
    delete updatedFields.createdAt;

    try {
        console.log(`Updating Activity ${activityId}:`, updatedFields);
        const [result] = await pool.query('UPDATE kemri_activities SET ? WHERE activityId = ?', [updatedFields, activityId]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_activities WHERE activityId = ?', [activityId]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Activity not found' });
        }
    } catch (error) {
        console.error('Error updating activity:', error);
        res.status(500).json({ message: 'Error updating activity', error: error.message });
    }
});

// DELETE an activity (soft delete)
router.delete('/:activityId', async (req, res) => {
    const { activityId } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_activities SET voided = 1 WHERE activityId = ?', [activityId]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Activity not found' });
        }
    } catch (error) {
        console.error('Error soft-deleting activity:', error);
        res.status(500).json({ message: 'Error soft-deleting activity', error: error.message });
    }
});

module.exports = router;