// backend/routes/paymentRequestRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const auth = require('../middleware/authenticate');
const privilege = require('../middleware/privilegeMiddleware');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

// Main upload directory for payment requests
const baseUploadDir = path.join(__dirname, '..', '..', 'uploads', 'payment-requests');

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
        console.log(`Multer destination function called for file: ${file.originalname}`);

        // Get the requestId from the request parameters
        const { requestId } = req.params;
        if (!requestId) {
            console.error("Missing requestId in request parameters. Cannot create structured upload path.");
            // Fallback to the base directory to prevent a crash
            return cb(null, baseUploadDir);
        }

        // Construct the specific upload directory for this request
        const requestUploadDir = path.join(baseUploadDir, requestId);

        // Ensure the directory exists.
        if (!fs.existsSync(requestUploadDir)) {
            fs.mkdirSync(requestUploadDir, { recursive: true });
        }
        cb(null, requestUploadDir);
    },
    filename: (req, file, cb) => {
        // Generate a unique filename while preserving the original file extension
        const fileExtension = path.extname(file.originalname);
        cb(null, `${uuidv4()}${fileExtension}`);
    }
});

const upload = multer({ storage });


// Helper function to format dates for MySQL (YYYY-MM-DD)
const formatDate = (dateString) => {
    if (!dateString) return null;
    return new Date(dateString).toISOString().slice(0, 10);
};

// @route   POST /api/payment-requests
// @desc    A contractor submits a new payment request with activities, documents, and inspection team.
// @access  Private (contractor only)
router.post('/', auth, privilege(['payment_request.create']), async (req, res) => {
    const {
        projectId, contractorId, amount, description, activities, documents, inspectionTeam
    } = req.body;

    const userId = req.user.id;

    if (!projectId || !contractorId || !amount || !description || !activities || activities.length === 0) {
        return res.status(400).json({ message: 'Missing required fields: projectId, contractorId, amount, description, and at least one activity.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        // 1. Insert into kemri_project_payment_requests
        const newRequest = {
            projectId, contractorId, amount, description, userId,
            approvalStatus: 'pending', overallStatus: 'pending', status: 'Pending Submission'
        };
        const [requestResult] = await connection.query('INSERT INTO kemri_project_payment_requests SET ?', newRequest);
        const requestId = requestResult.insertId;

        // 2. Insert into kemri_payment_request_milestones
        if (activities && activities.length > 0) {
            const milestoneValues = activities.map(activity => [requestId, activity.activityId, 'accomplished', userId]);
            await connection.query('INSERT INTO kemri_payment_request_milestones (requestId, activityId, status, userId) VALUES ?', [milestoneValues]);
        }

        // 3. Insert into kemri_payment_request_documents
        if (documents && documents.length > 0) {
            const documentValues = documents.map(doc => [requestId, doc.documentType, doc.documentPath, doc.description, userId]);
            await connection.query('INSERT INTO kemri_payment_request_documents (requestId, documentType, documentPath, description, uploadedByUserId) VALUES ?', [documentValues]);
        }

        // 4. Insert into kemri_inspection_teams
        if (inspectionTeam && inspectionTeam.length > 0) {
            const teamValues = inspectionTeam.map(member => [requestId, member.staffId, member.role, userId]);
            await connection.query('INSERT INTO kemri_inspection_teams (requestId, staffId, role, userId) VALUES ?', [teamValues]);
        }

        // 5. Commit the transaction
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

// @route   POST /api/payment-requests/documents/:requestId
// @desc    Upload documents and photos for an existing payment request
// @access  Private (e.g., requires 'payment_request.upload_document' privilege)
router.post('/documents/:requestId', auth, privilege(['payment_request.upload_document']), upload.array('documents'), async (req, res) => {
    // 🐛 FIX: Added a safeguard (req.body || {}) to prevent destructuring from undefined
    const { documentType } = req.body || {};
    const { requestId } = req.params;
    const userId = req.user.id;
    const files = req.files;

    // 🐛 DEBUGGING: Log req.body and req.files to see what multer is populating them with
    console.log("Req.body from multer:", req.body);
    console.log("Req.files from multer:", files);

    if (!files || files.length === 0 || !documentType) {
        console.error("No files received or document type is missing.");
        return res.status(400).json({ message: 'Missing files or document type.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        const documentValues = files.map(file => {
            // Updated documentPath to reflect the new nested folder structure
            // Use path.relative to create a clean, relative path
            const documentPath = path.relative(path.join(__dirname, '..', '..'), file.path);
            return [requestId, documentType, documentPath.replace(/\\/g, '/'), null, userId];
        });

        await connection.query(
            'INSERT INTO kemri_payment_request_documents (requestId, documentType, documentPath, description, uploadedByUserId) VALUES ?',
            [documentValues]
        );
        
        await connection.commit();
        res.status(201).json({ message: 'Documents uploaded successfully.' });

    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error uploading documents:', error);
        res.status(500).json({ message: 'Error uploading documents', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});


// @route   PUT /api/payment-requests/:requestId/approve
// @desc    A project manager approves a specific stage of a payment request.
// @access  Private (e.g., requires 'payment_request.approve' privilege)
router.put('/:requestId/approve', auth, privilege(['payment_request.approve']), async (req, res) => {
    const { requestId } = req.params;
    const { stage, comments } = req.body;
    const userId = req.user.id;
    
    if (!stage) {
        return res.status(400).json({ message: 'Approval stage is required.' });
    }

    let connection;
    try {
        connection = await db.getConnection();
        await connection.beginTransaction();

        // 1. Record the approval action in the approvals table
        const [approvalResult] = await connection.query(
            'INSERT INTO kemri_payment_request_approvals (requestId, stage, status, comments, actionByUserId) VALUES (?, ?, ?, ?, ?)',
            [requestId, stage, 'approved', comments, userId]
        );

        // 2. Update the main request table with the current status and stage
        await connection.query(
            'UPDATE kemri_project_payment_requests SET status = ?, approvalStatus = ?, currentStageId = ?, updatedAt = CURRENT_TIMESTAMP WHERE requestId = ?',
            [stage, 'approved', approvalResult.insertId, requestId]
        );
        
        await connection.commit();
        res.status(200).json({ message: `Payment request approved for stage: ${stage}.` });
    } catch (error) {
        if (connection) await connection.rollback();
        console.error('Error approving payment request:', error);
        res.status(500).json({ message: 'Error approving payment request', error: error.message });
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
        const [rows] = await connection.query('SELECT * FROM kemri_project_payment_requests WHERE projectId = ? AND voided = 0', [projectId]);
        res.json(rows);
    } catch (error) {
        console.error('Error fetching payment requests:', error);
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
        const [request] = await connection.query('SELECT * FROM kemri_project_payment_requests WHERE requestId = ? AND voided = 0', [requestId]);
        if (request.length === 0) {
            return res.status(404).json({ message: 'Payment request not found.' });
        }

        const [milestones] = await connection.query('SELECT * FROM kemri_payment_request_milestones WHERE requestId = ? AND voided = 0', [requestId]);
        const [documents] = await connection.query('SELECT * FROM kemri_payment_request_documents WHERE requestId = ? AND voided = 0', [requestId]);
        const [inspectionTeam] = await connection.query('SELECT * FROM kemri_inspection_teams WHERE requestId = ? AND voided = 0', [requestId]);
        const [approvals] = await connection.query('SELECT * FROM kemri_payment_request_approvals WHERE requestId = ? AND voided = 0', [requestId]);

        res.json({
            ...request[0],
            milestones,
            documents,
            inspectionTeam,
            approvals
        });
    } catch (error) {
        console.error('Error fetching detailed payment request:', error);
        res.status(500).json({ message: 'Error fetching detailed payment request', error: error.message });
    } finally {
      if (connection) connection.release();
    }
});

module.exports = router;
