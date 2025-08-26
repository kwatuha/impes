// backend/routes/paymentRequestRoutes.js
const express = require('express');
const router = require('express').Router();
const db = require('../config/db');
const auth = require('../middleware/authenticate');
const privilege = require('../middleware/privilegeMiddleware');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

// Main upload directory for all project documents
const baseUploadDir = path.join(__dirname, '..', '..', 'uploads');

// Ensure the base upload directory exists
if (!fs.existsSync(baseUploadDir)) {
    try {
        fs.mkdirSync(baseUploadDir, { recursive: true });
        console.log(`Created base upload directory: ${baseUploadDir}`);
    } catch (error) {
        console.error(`Error creating base upload directory: ${baseUploadDir}`, error);
    }
}

// Multer storage configuration for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const { projectId, documentCategory } = req.body;
        if (!projectId || !documentCategory) {
            return cb(new Error("Missing projectId or documentCategory in request body. Cannot save file."));
        }
        const projectUploadDir = path.join(baseUploadDir, 'projects', projectId.toString());
        const documentUploadDir = path.join(projectUploadDir, documentCategory);
        if (!fs.existsSync(documentUploadDir)) {
            fs.mkdirSync(documentUploadDir, { recursive: true });
        }
        cb(null, documentUploadDir);
    },
    filename: (req, file, cb) => {
        const fileExtension = path.extname(file.originalname);
        cb(null, `${uuidv4()}${fileExtension}`);
    }
});

const upload = multer({ storage });


// @route   POST /api/payment-requests
// @desc    A contractor submits a new payment request with activities, documents, and inspection team.
// @access  Private (contractor only)
router.post('/', auth, privilege(['payment_request.create']), async (req, res) => {
    const {
        projectId, contractorId, amount, description, activities, documents, inspectionTeam
    } = req.body;
    const userId = req.user.id;
    if (!projectId || !contractorId || !amount || !description || !activities || activities.length === 0) {
        return res.status(400).json({ message: 'Missing required fields.' });
    }
    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();
        const newRequest = {
            projectId, contractorId, amount, description, userId,
            paymentStatusId: 1, // 'Submitted' status assumed to be ID 1
            currentApprovalLevelId: 1
        };
        const [requestResult] = await connection.query('INSERT INTO kemri_project_payment_requests SET ?', newRequest);
        const requestId = requestResult.insertId;
        if (activities && activities.length > 0) {
            const milestoneValues = activities.map(activity => [requestId, activity.activityId, 'accomplished', userId]);
            await connection.query('INSERT INTO kemri_payment_request_milestones (requestId, activityId, status, userId) VALUES ?', [milestoneValues]);
        }
        if (documents && documents.length > 0) {
            const documentValues = documents.map(doc => [
                doc.projectId, doc.milestoneId, doc.requestId, doc.documentType, 'payment', doc.documentPath,
                doc.description, userId, 0, 0, new Date(), new Date()
            ]);
            await connection.query(`INSERT INTO kemri_project_documents (projectId, milestoneId, requestId, documentType, documentCategory, documentPath, description, userId, isProjectCover, voided, createdAt, updatedAt) VALUES ?`, [documentValues]);
        }
        if (inspectionTeam && inspectionTeam.length > 0) {
            const teamValues = inspectionTeam.map(member => [requestId, member.staffId, member.role, userId]);
            await connection.query('INSERT INTO kemri_inspection_teams (requestId, staffId, role, userId) VALUES ?', [teamValues]);
        }
        const historyData = { requestId, action: 'Submitted', actionByUserId: userId, notes: 'Payment request submitted by contractor.' };
        await connection.query('INSERT INTO kemri_payment_approval_history SET ?', historyData);
        await connection.commit();
        res.status(201).json({ message: 'Payment request submitted', requestId });
    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error submitting payment request:', error);
        res.status(500).json({ message: 'Error submitting payment request', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   PUT /api/payment-requests/:requestId/action
// @desc    Records an approval action and updates the request status.
// @access  Private (requires 'payment_request.update' privilege)
router.put('/:requestId/action', auth, privilege(['payment_request.update']), async (req, res) => {
    const { requestId } = req.params;
    const { action, notes, assignedToUserId } = req.body;
    const actionByUserId = req.user.id;
    if (!action) {
        return res.status(400).json({ message: 'Action is required.' });
    }
    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();
        const [requests] = await connection.query(
            `SELECT p.projectId, p.paymentStatusId, p.currentApprovalLevelId, u.roleId
             FROM kemri_project_payment_requests p
             JOIN kemri_users u ON p.userId = u.userId
             WHERE p.requestId = ?`, [requestId]
        );
        if (requests.length === 0) {
            await connection.rollback();
            return res.status(404).json({ message: `Payment request with ID: ${requestId} not found.` });
        }
        const { currentApprovalLevelId } = requests[0];
        const [currentLevel] = await connection.query('SELECT roleId FROM kemri_payment_approval_levels WHERE levelId = ?', [currentApprovalLevelId]);
        if (action === 'Approve' && (currentLevel.length === 0 || currentLevel[0].roleId !== req.user.roleId)) {
             await connection.rollback();
             return res.status(403).json({ message: 'User is not authorized to approve at this stage.' });
        }
        let newStatusId;
        let newApprovalLevelId = currentApprovalLevelId;

        if (action === 'Approve') {
            const [nextLevel] = await connection.query(
                `SELECT levelId, levelName, approvalOrder FROM kemri_payment_approval_levels WHERE approvalOrder > (SELECT approvalOrder FROM kemri_payment_approval_levels WHERE levelId = ?) ORDER BY approvalOrder ASC LIMIT 1`, [currentApprovalLevelId]
            );
            
            if (nextLevel.length > 0) {
                const nextLevelName = nextLevel[0].levelName;
                const [nextStatus] = await connection.query('SELECT statusId FROM kemri_payment_status_definitions WHERE statusName = ?', [`Awaiting ${nextLevelName} Review`]);
                newStatusId = nextStatus.length > 0 ? nextStatus[0].statusId : newStatusId;
                newApprovalLevelId = nextLevel[0].levelId;
            } else {
                const [approvedStatus] = await connection.query('SELECT statusId FROM kemri_payment_status_definitions WHERE statusName = ?', ['Approved for Payment']);
                newStatusId = approvedStatus.length > 0 ? approvedStatus[0].statusId : newStatusId;
                newApprovalLevelId = null;
            }
        } else if (action === 'Reject') {
            const [rejectedStatus] = await connection.query('SELECT statusId FROM kemri_payment_status_definitions WHERE statusName = ?', ['Rejected']);
            newStatusId = rejectedStatus.length > 0 ? rejectedStatus[0].statusId : newStatusId;
            newApprovalLevelId = null;
        } else if (action === 'Returned for Correction') {
            const [returnedStatus] = await connection.query('SELECT statusId FROM kemri_payment_status_definitions WHERE statusName = ?', ['Returned for Correction']);
            newStatusId = returnedStatus.length > 0 ? returnedStatus[0].statusId : newStatusId;
            newApprovalLevelId = currentApprovalLevelId;
        }

        if (newStatusId === null) {
             await connection.rollback();
             return res.status(500).json({ message: 'Failed to find a valid status ID for the action.' });
        }

        await connection.query('UPDATE kemri_project_payment_requests SET paymentStatusId = ?, currentApprovalLevelId = ? WHERE requestId = ?', [newStatusId, newApprovalLevelId, requestId]);
        const historyData = { requestId, action, actionByUserId, assignedToUserId, notes };
        await connection.query('INSERT INTO kemri_payment_approval_history SET ?', historyData);
        await connection.commit();
        const [updatedRequest] = await connection.query(`SELECT statusName FROM kemri_payment_status_definitions WHERE statusId = ?`, [newStatusId]);
        res.status(200).json({ message: `Payment request status updated to: ${updatedRequest[0].statusName}.` });
    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error recording approval action:', error);
        res.status(500).json({ message: 'Error recording approval action', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   GET /api/payment-requests/:requestId/history
// @desc    Fetches the approval history for a specific payment request.
// @access  Private (requires 'payment_request.read' privilege)
router.get('/:requestId/history', auth, privilege(['payment_request.read']), async (req, res) => {
    const { requestId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        const [rows] = await connection.query(
            `SELECT h.*, CONCAT(u.firstName, ' ', u.lastName) AS actionByUserName, CONCAT(u2.firstName, ' ', u2.lastName) AS assignedToUserName
             FROM kemri_payment_approval_history h
             JOIN kemri_users u ON h.actionByUserId = u.userId
             LEFT JOIN kemri_users u2 ON h.assignedToUserId = u2.userId
             WHERE h.requestId = ? ORDER BY h.actionDate ASC`, [requestId]);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching payment approval history', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   POST /api/payment-requests/:requestId/payment-details
// @desc    Records the final payment details for a paid request.
// @access  Private (requires 'payment_details.create' privilege)
router.post('/:requestId/payment-details', auth, privilege(['payment_details.create']), async (req, res) => {
    const { requestId } = req.params;
    const { paymentMode, bankName, accountNumber, transactionId, notes } = req.body;
    const paidByUserId = req.user.id;
    if (!paymentMode) {
        return res.status(400).json({ message: 'paymentMode is required.' });
    }
    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();
        const [paidStatus] = await connection.query('SELECT statusId FROM kemri_payment_status_definitions WHERE statusName = ?', ['Paid']);
        const paymentDetails = {
            requestId, paymentMode, bankName, accountNumber, transactionId, notes, paidByUserId, createdByUserId: paidByUserId
        };
        await connection.query('INSERT INTO kemri_payment_details SET ?', paymentDetails);
        await connection.query('UPDATE kemri_project_payment_requests SET paymentStatusId = ? WHERE requestId = ?', [paidStatus[0].statusId, requestId]);
        await connection.commit();
        const [updatedRequest] = await connection.query(`SELECT statusName FROM kemri_payment_status_definitions WHERE statusId = ?`, [paidStatus[0].statusId]);
        res.status(201).json({ message: `Payment details recorded and request status updated to ${updatedRequest[0].statusName}.` });
    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error recording payment details:', error);
        res.status(500).json({ message: `Failed to record payment details for request ID: ${requestId}.`, error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   GET /api/payment-requests/:requestId/payment-details
// @desc    Get the final payment details for a specific request.
// @access  Private (requires 'payment_details.read' privilege)
router.get('/:requestId/payment-details', auth, privilege(['payment_details.read']), async (req, res) => {
    const { requestId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        const [rows] = await connection.query('SELECT * FROM kemri_payment_details WHERE requestId = ?', [requestId]);
        if (rows.length === 0) {
            return res.status(404).json({ message: `Payment details not found for request ID: ${requestId}.` });
        }
        res.json(rows[0]);
    } catch (error) {
        res.status(500).json({ message: 'Failed to fetch payment details', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   GET /api/payment-requests/project/:projectId
// @desc    Get all payment requests for a specific project.
// @access  Private (requires 'payment_request.read_all' or 'payment_request.read_own' privilege)
router.get('/project/:projectId', auth, privilege(['payment_request.read_all']), async (req, res) => {
    const { projectId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        const [rows] = await connection.query(`SELECT p.*, ps.statusName AS paymentStatus
                                               FROM kemri_project_payment_requests p
                                               LEFT JOIN kemri_payment_status_definitions ps ON p.paymentStatusId = ps.statusId
                                               WHERE p.projectId = ? AND p.voided = 0`, [projectId]);
        res.json(rows);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching payment requests', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   GET /api/payment-requests/request/:requestId
// @desc    Get a specific payment request with all its related details.
// @access  Private (requires 'payment_request.read_all' or 'payment_request.read_own' privilege)
router.get('/request/:requestId', auth, privilege(['payment_request.read_all']), async (req, res) => {
    const { requestId } = req.params;
    let connection;
    try {
        connection = await db.getConnection();
        const [request] = await connection.query(
            `SELECT p.*,
                    ps.statusName AS paymentStatus,
                    p.currentApprovalLevelId,
                    r.roleName AS userRoleName,
                    r.roleId AS userRoleId
             FROM kemri_project_payment_requests p
             LEFT JOIN kemri_payment_status_definitions ps ON p.paymentStatusId = ps.statusId
             LEFT JOIN kemri_users u ON p.userId = u.userId
             LEFT JOIN kemri_roles r ON u.roleId = r.roleId
             WHERE p.requestId = ? AND p.voided = 0`,
            [requestId]
        );

        if (request.length === 0) {
            return res.status(404).json({ message: `Payment request with ID: ${requestId} not found.` });
        }

        const [milestones] = await connection.query('SELECT * FROM kemri_payment_request_milestones WHERE requestId = ? AND voided = 0', [requestId]);
        const [documents] = await connection.query('SELECT * FROM kemri_project_documents WHERE requestId = ? AND voided = 0', [requestId]);
        const [inspectionTeam] = await connection.query('SELECT * FROM kemri_inspection_teams WHERE requestId = ? AND voided = 0', [requestId]);
        const [approvals] = await connection.query('SELECT * FROM kemri_payment_request_approvals WHERE requestId = ? AND voided = 0', [requestId]);
        const [paymentDetails] = await connection.query('SELECT * FROM kemri_payment_details WHERE requestId = ?', [requestId]);

        res.json({
            ...request[0],
            milestones,
            documents,
            inspectionTeam,
            approvals,
            paymentDetails: paymentDetails.length > 0 ? paymentDetails[0] : null
        });
    } catch (error) {
        console.error('Error fetching detailed payment request:', error);
        res.status(500).json({ message: 'Error fetching detailed payment request', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});

module.exports = router;