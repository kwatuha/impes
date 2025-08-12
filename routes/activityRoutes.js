// src/routes/activityRoutes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db');

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

// POST a new activity
router.post('/', async (req, res) => {
    const newActivity = { ...req.body, voided: 0 };
    try {
        const [result] = await pool.query('INSERT INTO kemri_activities SET ?', newActivity);
        res.status(201).json({ ...newActivity, activityId: result.insertId });
    } catch (error) {
        console.error('Error creating activity:', error);
        res.status(500).json({ message: 'Error creating activity', error: error.message });
    }
});

// Other CRUD routes (PUT, DELETE) would follow a similar pattern...
// PUT /:activityId
// DELETE /:activityId

module.exports = router;