// src/routes/milestoneActivityRoutes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db');

// GET all activities for a specific milestone
router.get('/by-milestone/:milestoneId', async (req, res) => {
    const { milestoneId } = req.params;
    try {
        const [rows] = await pool.query('SELECT a.*, ma.milestoneId FROM kemri_activities a JOIN kemri_milestone_activities ma ON a.activityId = ma.activityId WHERE ma.milestoneId = ? AND a.voided = 0', [milestoneId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching milestone activities:', error);
        res.status(500).json({ message: 'Error fetching milestone activities', error: error.message });
    }
});

// GET all milestone-activity links for a given activity
router.get('/by-activity/:activityId', async (req, res) => {
    const { activityId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_milestone_activities WHERE activityId = ?', [activityId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching milestone-activity links by activity ID:', error);
        res.status(500).json({ message: 'Error fetching milestone-activity links', error: error.message });
    }
});

// POST a new link between a milestone and an activity
router.post('/', async (req, res) => {
    const { milestoneId, activityId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_milestone_activities (milestoneId, activityId) VALUES (?, ?)', [milestoneId, activityId]);
        res.status(201).json({ id: result.insertId, milestoneId, activityId });
    } catch (error) {
        console.error('Error creating milestone activity link:', error);
        res.status(500).json({ message: 'Error creating milestone activity link', error: error.message });
    }
});

// DELETE a link between a milestone and an activity
router.delete('/:milestoneId/:activityId', async (req, res) => {
    const { milestoneId, activityId } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_milestone_activities WHERE milestoneId = ? AND activityId = ?', [milestoneId, activityId]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Milestone-Activity link not found' });
        }
    } catch (error) {
        console.error('Error deleting milestone activity link:', error);
        res.status(500).json({ message: 'Error deleting milestone activity link', error: error.message });
    }
});

module.exports = router;