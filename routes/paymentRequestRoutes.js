// src/routes/paymentRequestRoutes.js

const express = require('express');
const router = express.Router();
const pool = require('../config/db');

/**
 * @route POST /api/payment-requests
 * @description A contractor submits a new payment request.
 * @access Private (contractor only)
 */
router.post('/', async (req, res) => {
    // TODO: Get contractorId from authenticated user profile
    const contractorId = 1; // Placeholder for now
    const { projectId, amount, description } = req.body;
    if (!projectId || !amount || !description) {
        return res.status(400).json({ message: 'Missing required fields: projectId, amount, description.' });
    }
    const newRequest = { projectId, contractorId, amount, description };
    try {
        const [result] = await pool.query('INSERT INTO kemri_project_payment_requests SET ?', newRequest);
        res.status(201).json({ message: 'Payment request submitted', requestId: result.insertId });
    } catch (error) {
        console.error('Error submitting payment request:', error);
        res.status(500).json({ message: 'Error submitting payment request', error: error.message });
    }
});

/**
 * @route PUT /api/payment-requests/:requestId/status
 * @description A project manager updates the status of a payment request.
 * @access Private (project manager only)
 */
router.put('/:requestId/status', async (req, res) => {
    const { requestId } = req.params;
    const { status } = req.body;
    if (!status) {
        return res.status(400).json({ message: 'New status is required.' });
    }
    try {
        const [result] = await pool.query('UPDATE kemri_project_payment_requests SET status = ? WHERE requestId = ?', [status, requestId]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Payment request not found.' });
        }
        res.status(200).json({ message: 'Payment request status updated successfully.' });
    } catch (error) {
        console.error('Error updating payment request status:', error);
        res.status(500).json({ message: 'Error updating payment request status', error: error.message });
    }
});

module.exports = router;