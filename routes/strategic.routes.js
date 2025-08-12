// src/routes/strategic.routes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool
const multer = require('multer'); // Import multer
const path = require('path'); // Import path module for file paths
const fs = require('fs'); // Import fs module for file system operations (like deleting files)
const xlsx = require('xlsx'); // Import xlsx for Excel parsing
const PDFDocument = require('pdfkit'); // NEW: Import pdfkit for PDF generation

// --- NEW IMPORTS: Annual Work Plans and Activities ---
const annualWorkPlanRoutes = require('./annualWorkPlanRoutes');
const activityRoutes = require('./activityRoutes');

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

// --- Multer Configuration for File Uploads ---
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/');
    },
    filename: (req, file, cb) => {
        cb(null, `${Date.now()}-${file.originalname}`);
    }
});

const upload = multer({ storage: storage });

// --- Helper for PDF Table Generation ---
const drawTable = (doc, table, x, y, options = {}) => {
    const { addHeader = true, columnsSize = [], padding = 5 } = options;
    let currentY = y;
    
    if (addHeader) {
      doc.font('Helvetica-Bold').fontSize(10);
      let currentX = x;
      table.headers.forEach((header, index) => {
        doc.text(header, currentX, currentY, { width: columnsSize[index] - padding, align: 'center' });
        currentX += columnsSize[index];
      });
      doc.moveDown(0.5);
      currentY = doc.y;
    }

    doc.font('Helvetica').fontSize(10);
    table.rows.forEach(row => {
      let currentX = x;
      row.forEach((cell, index) => {
        doc.text(String(cell), currentX, currentY, { width: columnsSize[index] - padding, align: 'center' });
        currentX += columnsSize[index];
      });
      doc.moveDown(0.5);
      currentY = doc.y;
    });
};

// --- Helper for PDF Currency Formatting ---
const formatCurrencyForPdf = (value) => {
    const num = parseFloat(value);
    if (isNaN(num)) {
        return 'N/A';
    }
    return `KES ${num.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',')}`;
};

// --- Mount the new routers for work plans and activities ---
router.use('/workplans', annualWorkPlanRoutes);
router.use('/activities', activityRoutes);

// --- CRUD Operations for Strategic Plans (kemri_strategicPlans) ---
router.get('/strategic_plans', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_strategicPlans');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching strategic plans:', error);
        res.status(500).json({ message: 'Error fetching strategic plans', error: error.message });
    }
});

router.get('/strategic_plans/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_strategicPlans WHERE id = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Strategic plan not found' });
        }
    } catch (error) {
        console.error('Error fetching strategic plan:', error);
        res.status(500).json({ message: 'Error fetching strategic plan', error: error.message });
    }
});

router.post('/strategic_plans', async (req, res) => {
    const clientData = req.body;

    const newPlan = {
        startDate: formatToMySQLDateTime(clientData.startDate),
        endDate: formatToMySQLDateTime(clientData.endDate),
        ...clientData,
        voided: 0,
        createdAt: new Date(),
        updatedAt: new Date(),
    };
    delete newPlan.id;

    try {
        console.log('Inserting Strategic Plan:', newPlan);
        const [result] = await pool.query('INSERT INTO kemri_strategicPlans SET ?', newPlan);

        if (result.insertId) {
            newPlan.id = result.insertId;
        }
        res.status(201).json(newPlan);
    } catch (error) {
        console.error('Error creating strategic plan:', error);
        res.status(500).json({ message: 'Error creating strategic plan', error: error.message });
    }
});

router.put('/strategic_plans/:id', async (req, res) => {
    const { id } = req.params;
    const clientData = req.body;

    const updatedFields = {
        startDate: clientData.startDate ? formatToMySQLDateTime(clientData.startDate) : undefined,
        endDate: clientData.endDate ? formatToMySQLDateTime(clientData.endDate) : undefined,
        ...clientData,
        updatedAt: new Date(),
    };
    delete updatedFields.id;
    delete updatedFields.voided;
    delete updatedFields.createdAt;

    try {
        console.log(`Updating Strategic Plan ${id}:`, updatedFields);
        const [result] = await pool.query('UPDATE kemri_strategicPlans SET ? WHERE id = ?', [updatedFields, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_strategicPlans WHERE id = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Strategic plan not found' });
        }
    } catch (error) {
        console.error('Error updating strategic plan:', error);
        res.status(500).json({ message: 'Error updating strategic plan', error: error.message });
    }
});

router.delete('/strategic_plans/:id', async (req, res) => {
    const { id } = req.params;
    try {
        console.log('Soft-deleting Strategic Plan:', id);
        const [result] = await pool.query('UPDATE kemri_strategicPlans SET voided = 1 WHERE id = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Strategic plan not found' });
        }
    } catch (error) {
        console.error('Error soft-deleting strategic plan:', error);
        res.status(500).json({ message: 'Error soft-deleting strategic plan', error: error.message });
    }
});

// --- CRUD Operations for Programs (kemri_programs) ---
router.get('/programs', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_programs WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching programs:', error);
        res.status(500).json({ message: 'Error fetching programs', error: error.message });
    }
});

router.get('/programs/by-plan/:planId', async (req, res) => {
    const { planId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_programs WHERE cidpid = ? AND voided = 0', [planId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching programs for plan ${planId}:`, error);
        res.status(500).json({ message: `Error fetching programs for plan ${planId}`, error: error.message });
    }
});

router.get('/programs/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_programs WHERE programId = ? AND voided = 0', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Program not found' });
        }
    } catch (error) {
        console.error('Error fetching program:', error);
        res.status(500).json({ message: 'Error fetching program', error: error.message });
    }
});

router.post('/programs', async (req, res) => {
    const clientData = req.body;
    const newProgram = {
        ...clientData,
        voided: 0,
        createdAt: new Date(),
        updatedAt: new Date(),
    };
    delete newProgram.programId;

    try {
        console.log('Inserting Program:', newProgram);
        const [result] = await pool.query('INSERT INTO kemri_programs SET ?', newProgram);
        if (result.insertId) {
            newProgram.programId = result.insertId;
        }
        res.status(201).json(newProgram);
    } catch (error) {
        console.error('Error creating program:', error);
        res.status(500).json({ message: 'Error creating program', error: error.message });
    }
});

router.put('/programs/:id', async (req, res) => {
    const { id } = req.params;
    const clientData = req.body;
    const updatedFields = {
        ...clientData,
        updatedAt: new Date(),
    };
    delete updatedFields.programId;
    delete updatedFields.voided;
    delete updatedFields.createdAt;

    try {
        console.log(`Updating Program ${id}:`, updatedFields);
        const [result] = await pool.query('UPDATE kemri_programs SET ? WHERE programId = ?', [updatedFields, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_programs WHERE programId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Program not found' });
        }
    }
    catch (error) {
        console.error('Error updating program:', error);
        res.status(500).json({ message: 'Error updating program', error: error.message });
    }
});

router.delete('/programs/:id', async (req, res) => {
    const { id } = req.params;
    try {
        console.log('Soft-deleting Program:', id);
        const [result] = await pool.query('UPDATE kemri_programs SET voided = 1 WHERE programId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Program not found' });
        }
    } catch (error) {
        console.error('Error soft-deleting program:', error);
        res.status(500).json({ message: 'Error soft-deleting program', error: error.message });
    }
});

// --- CRUD Operations for Subprograms (kemri_subprograms) ---
router.get('/subprograms', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_subprograms WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching subprograms:', error);
        res.status(500).json({ message: 'Error fetching subprograms', error: error.message });
    }
});

router.get('/subprograms/by-program/:programId', async (req, res) => {
    const { programId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_subprograms WHERE programId = ? AND voided = 0', [programId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching subprograms for program ${programId}:`, error);
        res.status(500).json({ message: `Error fetching subprograms for program ${programId}`, error: error.message });
    }
});

router.get('/subprograms/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_subprograms WHERE subProgramId = ? AND voided = 0', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Subprogram not found' });
        }
    } catch (error) {
        console.error('Error fetching subprogram:', error);
        res.status(500).json({ message: 'Error fetching subprogram', error: error.message });
    }
});

router.post('/subprograms', async (req, res) => {
    const clientData = req.body;
    const newSubprogram = {
        ...clientData,
        voided: 0,
        createdAt: new Date(),
        updatedAt: new Date(),
    };
    delete newSubprogram.subProgramId;

    try {
        console.log('Inserting Subprogram:', newSubprogram);
        const [result] = await pool.query('INSERT INTO kemri_subprograms SET ?', newSubprogram);
        if (result.insertId) {
            newSubprogram.subProgramId = result.insertId;
        }
        res.status(201).json(newSubprogram);
    } catch (error) {
        console.error('Error creating subprogram:', error);
        res.status(500).json({ message: 'Error creating subprogram', error: error.message });
    }
});

router.put('/subprograms/:id', async (req, res) => {
    const { id } = req.params;
    const clientData = req.body;
    const updatedFields = {
        ...clientData,
        updatedAt: new Date(),
    };
    delete updatedFields.subProgramId;
    delete updatedFields.voided;
    delete updatedFields.createdAt;

    try {
        console.log(`Updating Subprogram ${id}:`, updatedFields);
        const [result] = await pool.query('UPDATE kemri_subprograms SET ? WHERE subProgramId = ?', [updatedFields, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_subprograms WHERE subProgramId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Subprogram not found' });
        }
    }
    catch (error) {
        console.error('Error updating subprogram:', error);
        res.status(500).json({ message: 'Error updating subprogram', error: error.message });
    }
});

router.delete('/subprograms/:id', async (req, res) => {
    const { id } = req.params;
    try {
        console.log('Soft-deleting Subprogram:', id);
        const [result] = await pool.query('UPDATE kemri_subprograms SET voided = 1 WHERE subProgramId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Subprogram not found' });
        }
    } catch (error) {
        console.error('Error soft-deleting subprogram:', error);
        res.status(500).json({ message: 'Error soft-deleting subprogram', error: error.message });
    }
});


// --- CRUD Operations for Strategy Attachments (kemri_planningDocuments) ---
router.get('/attachments', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_planningDocuments WHERE voided = 0');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching strategic planning documents:', error);
        res.status(500).json({ message: 'Error fetching strategic planning documents', error: error.message });
    }
});

router.get('/attachments/by-entity/:entityType/:entityId', async (req, res) => {
    const { entityType, entityId } = req.params;
    try {
        const [rows] = await pool.query(
            'SELECT * FROM kemri_planningDocuments WHERE entityType = ? AND entityId = ? AND voided = 0',
            [entityType, entityId]
        );
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching documents for entity ${entityType}:${entityId}:`, error);
        res.status(500).json({ message: `Error fetching documents for entity ${entityType}:${entityId}`, error: error.message });
    }
});

router.get('/attachments/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_planningDocuments WHERE attachmentId = ? AND voided = 0', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Strategic planning document not found' });
        }
    } catch (error) {
        console.error('Error fetching strategic planning document:', error);
        res.status(500).json({ message: 'Error fetching strategic planning document', error: error.message });
    }
});

router.post('/attachments', upload.single('file'), async (req, res) => {
    const { fileName, fileType, fileSize, description, entityId, entityType, uploadedBy } = req.body;
    const filePath = req.file ? `/uploads/${req.file.filename}` : null;

    if (!req.file) {
        return res.status(400).json({ message: 'No file uploaded.' });
    }
    if (!fileName) {
        return res.status(400).json({ message: 'File name is required.' });
    }

    const newAttachment = {
        fileName: fileName,
        filePath: filePath,
        fileType: fileType || req.file.mimetype,
        fileSize: fileSize || req.file.size,
        description: description,
        entityId: entityId,
        entityType: entityType,
        uploadedBy: uploadedBy || null,
        createdAt: formatToMySQLDateTime(new Date()),
        updatedAt: formatToMySQLDateTime(new Date()),
    };

    try {
        console.log('Inserting Strategic Planning Document:', newAttachment);
        const [result] = await pool.query('INSERT INTO kemri_planningDocuments SET ?', newAttachment);
        if (result.insertId) {
            newAttachment.attachmentId = result.insertId;
        }
        res.status(201).json(newAttachment);
    } catch (error) {
        console.error('Error creating strategic planning document:', error);
        res.status(500).json({ message: 'Error creating strategic planning document', error: error.message });
    }
});

router.put('/attachments/:id', async (req, res) => {
    const { id } = req.params;
    const clientData = req.body;
    const updatedFields = {
        updatedAt: formatToMySQLDateTime(new Date()),
        ...clientData
    };
    delete updatedFields.attachmentId;

    try {
        console.log(`Updating Strategic Planning Document ${id}:`, updatedFields);
        const [rows] = await pool.query('UPDATE kemri_planningDocuments SET ? WHERE attachmentId = ?', [updatedFields, id]);
        if (rows.affectedRows > 0) {
            const [updatedRow] = await pool.query('SELECT * FROM kemri_planningDocuments WHERE attachmentId = ?', [id]);
            res.status(200).json(updatedRow[0]);
        } else {
            res.status(404).json({ message: 'Strategic planning document not found' });
        }
    } catch (error) {
        console.error('Error updating strategic planning document:', error);
        res.status(500).json({ message: 'Error updating strategic planning document', error: error.message });
    }
});

router.delete('/attachments/:id', async (req, res) => {
    const { id } = req.params;
    try {
        console.log('Soft-deleting Strategic Plan Attachment:', id);
        const [rows] = await pool.query('SELECT filePath FROM kemri_planningDocuments WHERE attachmentId = ?', [id]);
        if (rows.length === 0) {
            return res.status(400).json({ message: 'Strategic planning document not found.' });
        }
        const filePathToDelete = rows[0].filePath;

        const [result] = await pool.query('UPDATE kemri_planningDocuments SET voided = 1 WHERE attachmentId = ?', [id]);
        if (result.affectedRows > 0) {
            if (filePathToDelete && filePathToDelete.startsWith('/uploads/')) {
                const absolutePath = path.join(__dirname, '..', filePathToDelete);
                fs.unlink(absolutePath, (err) => {
                    if (err) {
                        console.error('Error deleting physical file:', err);
                    } else {
                        console.log('Physical file deleted:', absolutePath);
                    }
                });
            }
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Strategic planning document not found' });
        }
    } catch (error) {
        console.error('Error soft-deleting strategic planning document:', error);
        res.status(500).json({ message: 'Error soft-deleting strategic planning document', error: error.message });
    }
});


// --- Route for Downloading Strategic Plan Template ---
router.get('/download-template', (req, res) => {
    const templateFilePath = path.join(__dirname, '..', 'templates', 'strategic_plan_template.xlsx');
    console.log('Attempting to send template from:', templateFilePath);

    res.download(templateFilePath, 'strategic_plan_template.xlsx', (err) => {
        if (err) {
            console.error('Error sending template file:', err);
            res.status(500).json({ message: 'Failed to download template file.', error: err.message });
        }
    });
});


// --- Route for Previewing Strategic Plan Data from Excel ---
router.post('/import-cidp', upload.single('importFile'), async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ success: false, message: 'No file uploaded.' });
    }

    const filePath = req.file.path;

    try {
        const workbook = xlsx.readFile(filePath, { cellDates: true });
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const rawData = xlsx.utils.sheet_to_json(worksheet, { header: 1 });

        if (rawData.length < 2) {
            fs.unlink(filePath, () => {});
            return res.status(400).json({ success: false, message: 'Uploaded Excel file is empty or has no data rows.' });
        }

        const headers = rawData[0];
        const dataRows = rawData.slice(1);

        const importSummary = {
            totalRows: dataRows.length,
            previewRows: [],
            unrecognizedHeaders: [],
            errors: []
        };

        const headerMap = {
            'plan_cidpid': 'Plan_CIDPID', 'plan cidpid': 'Plan_CIDPID', 'planid': 'Plan_CIDPID',
            'plan_name': 'Plan_Name', 'plan name': 'Plan_Name',
            'plan_startdate': 'Plan_StartDate', 'plan start date': 'Plan_StartDate', 'planstartdate': 'Plan_StartDate',
            'plan_enddate': 'Plan_EndDate', 'plan end date': 'Plan_EndDate', 'planenddate': 'Plan_EndDate',

            'program_name': 'Program_Name', 'program name': 'Program_Name', 'programname': 'Program_Name',
            'program_department': 'Program_Department', 'program department': 'Program_Department', 'programdepartment': 'Program_Department',
            'program_section': 'Program_Section', 'program section': 'Program_Section', 'programsection': 'Program_Section',
            'program_needspriorities': 'Program_NeedsPriorities', 'program needs priorities': 'Program_NeedsPriorities', 'programneedspriorities': 'Program_NeedsPriorities',
            'program_strategies': 'Program_Strategies', 'program strategies': 'Program_Strategies', 'programstrategies': 'Program_Strategies',
            'program_objectives': 'Program_Objectives', 'program objectives': 'Program_Objectives', 'programobjectives': 'Program_Objectives',
            'program_outcomes': 'Program_Outcomes', 'program outcomes': 'Program_Outcomes', 'programoutcomes': 'Program_Outcomes',
            'program_remarks': 'Program_Remarks', 'program remarks': 'Program_Remarks', 'programremarks': 'Program_Remarks',
            'key result area': 'Program_Name', 'kra': 'Program_Name', 'strategic objective': 'Program_Name',

            'subprogram_name': 'Subprogram_Name', 'subprogram name': 'Subprogram_Name', 'subprogramname': 'Subprogram_Name',
            'subprogram_keyoutcome': 'Subprogram_KeyOutcome', 'subprogram key outcome': 'Subprogram_KeyOutcome', 'subprogramkeyoutcome': 'Subprogram_KeyOutcome',
            'subprogram_kpi': 'Subprogram_KPI', 'subprogram kpi': 'Subprogram_KPI', 'subprogramkpi': 'Subprogram_KPI',
            'subprogram_baseline': 'Subprogram_Baseline', 'subprogram baseline': 'Subprogram_Baseline', 'subprogrambaseline': 'Subprogram_Baseline',
            'subprogram_yr1targets': 'Subprogram_Yr1Targets', 'subprogram yr1 targets': 'Subprogram_Yr1Targets', 'subprogramyr1targets': 'Subprogram_Yr1Targets',
            'subprogram_yr2targets': 'Subprogram_Yr2Targets', 'subprogram_yr3targets': 'Subprogram_Yr3Targets', 'subprogram_yr4targets': 'Subprogram_Yr4Targets', 'subprogram_yr5targets': 'Subprogram_Yr5Targets',
            'subprogram_yr1budget': 'Subprogram_Yr1Budget', 'subprogram_yr2budget': 'Subprogram_Yr2Budget', 'subprogram_yr3budget': 'Subprogram_Yr3Budget', 'subprogram_yr4budget': 'Subprogram_Yr4Budget', 'subprogram_yr5budget': 'Subprogram_Yr5Budget',
            'subprogram_totalbudget': 'Subprogram_TotalBudget', 'subprogram total budget': 'Subprogram_TotalBudget', 'subprogramtotalbudget': 'Subprogram_TotalBudget',
            'subprogram_remarks': 'Subprogram_Remarks', 'subprogram remarks': 'Subprogram_Remarks', 'subprogramremarks': 'Subprogram_Remarks',
            'initiative': 'Subprogram_Name', 'action plan': 'Subprogram_Name', 'project activity': 'Subprogram_Name',
        };

        const mapRowToObject = (rowArray) => {
            const obj = {};
            headers.forEach((rawHeader, index) => {
                const normalizedHeaderKey = String(rawHeader).toLowerCase().replace(/[^a-z0-9]/g, '');
                const targetHeader = headerMap[normalizedHeaderKey] || rawHeader;
                if (!Object.values(headerMap).includes(targetHeader) && !importSummary.unrecognizedHeaders.includes(rawHeader)) {
                    importSummary.unrecognizedHeaders.push(rawHeader);
                }
                let value = rowArray[index];
                if (value === '' || value === null || value === undefined) {
                    obj[targetHeader] = null;
                } else if (typeof value === 'number' && (targetHeader.includes('Targets') || targetHeader.includes('Budget'))) {
                    obj[targetHeader] = value;
                } else if (typeof value === 'object' && value instanceof Date) {
                    obj[targetHeader] = value.toISOString().split('T')[0];
                } else {
                    obj[targetHeader] = value;
                }
            });
            return obj;
        };

        const processedFullData = [];
        const previewLimit = 10;
        for (let i = 0; i < dataRows.length; i++) {
            const mappedRow = mapRowToObject(dataRows[i]);
            processedFullData.push(mappedRow);
            if (i < previewLimit) {
                importSummary.previewRows.push(mappedRow);
            }
        }
        fs.unlink(filePath, () => {});
        res.status(200).json({
            success: true,
            message: `File parsed successfully. Review ${importSummary.previewRows.length} of ${importSummary.totalRows} rows.`,
            previewData: importSummary.previewRows,
            headers: headers,
            fullData: processedFullData,
            unrecognizedHeaders: importSummary.unrecognizedHeaders,
        });

    } catch (error) {
        fs.unlink(filePath, () => {});
        console.error('Error during import preview process:', error);
        res.status(500).json({ success: false, message: `File parsing failed: ${error.message}` });
    } finally {}
});

router.post('/confirm-import-cidp', upload.none(), async (req, res) => {
    const { dataToImport } = req.body;
    if (!dataToImport || !Array.isArray(dataToImport) || dataToImport.length === 0) {
        return res.status(400).json({ success: false, message: 'No data provided for import confirmation.' });
    }

    let connection;
    const importSummary = {
        plansCreated: 0, plansUpdated: 0,
        programsCreated: 0, programsUpdated: 0,
        subprogramsCreated: 0, subprogramsUpdated: 0,
        errors: []
    };

    const processRowForDB = (row) => {
        const processedRow = {};
        for (const key in row) {
            if (Object.prototype.hasOwnProperty.call(row, key)) {
                let value = row[key];
                if (value === '' || value === null || value === undefined) {
                    processedRow[key] = null;
                } else if (typeof value === 'number' && (key.includes('Targets') || key.includes('Budget'))) {
                    processedRow[key] = value;
                } else if (typeof value === 'string' && (key.includes('StartDate') || key.includes('EndDate'))) {
                    processedRow[key] = formatToMySQLDateTime(value);
                } else {
                    processedRow[key] = value;
                }
            }
        }
        return processedRow;
    };


    try {
        connection = await pool.getConnection();
        await connection.beginTransaction();

        for (const row of dataToImport) {
            const processedRow = processRowForDB(row);
            try {
                let strategicPlanId = null;
                let planCidpId = processedRow['Plan_CIDPID'];

                if (!planCidpId) {
                    throw new Error('Plan_CIDPID is missing for a row.');
                }

                const [existingPlans] = await connection.query('SELECT id FROM kemri_strategicPlans WHERE cidpid = ?', [planCidpId]);
                if (existingPlans.length > 0) {
                    strategicPlanId = existingPlans[0].id;
                    await connection.query(
                        'UPDATE kemri_strategicPlans SET cidpName = ?, startDate = ?, endDate = ? WHERE id = ?',
                        [processedRow['Plan_Name'], processedRow['Plan_StartDate'], processedRow['Plan_EndDate'], strategicPlanId]
                    );
                    importSummary.plansUpdated++;
                } else {
                    const [insertResult] = await connection.query(
                        'INSERT INTO kemri_strategicPlans SET cidpid = ?, cidpName = ?, startDate = ?, endDate = ?',
                        [planCidpId, processedRow['Plan_Name'], processedRow['Plan_StartDate'], processedRow['Plan_EndDate']]
                    );
                    strategicPlanId = insertResult.insertId;
                    importSummary.plansCreated++;
                }

                let programId = null;
                let programName = processedRow['Program_Name'];

                if (!programName) {
                    throw new Error('Program_Name is missing for a row.');
                }

                const [existingPrograms] = await connection.query('SELECT programId FROM kemri_programs WHERE programme = ? AND cidpid = ?', [programName, planCidpId]);
                if (existingPrograms.length > 0) {
                    programId = existingPrograms[0].programId;
                    importSummary.programsUpdated++;
                } else {
                    let departmentId = null;
                    if (processedRow['Program_Department']) {
                        const [deptRows] = await connection.query('SELECT departmentId FROM kemri_departments WHERE name = ?', [processedRow['Program_Department']]);
                        if (deptRows.length > 0) {
                            departmentId = deptRows[0].departmentId;
                        } else {
                            const [newDept] = await connection.query('INSERT INTO kemri_departments (name) VALUES (?)', [processedRow['Program_Department']]);
                            departmentId = newDept.insertId;
                        }
                    }

                    let sectionId = null;
                    if (processedRow['Program_Section'] && departmentId) {
                        const [secRows] = await connection.query('SELECT sectionId FROM kemri_sections WHERE name = ? AND departmentId = ?', [processedRow['Program_Section'], departmentId]);
                        if (secRows.length > 0) {
                            sectionId = secRows[0].sectionId;
                        } else {
                            const [newSec] = await connection.query('INSERT INTO kemri_sections (name, departmentId) VALUES (?, ?)', [processedRow['Program_Section'], departmentId]);
                            sectionId = newSec.insertId;
                        }
                    }

                    const [insertResult] = await connection.query(
                        'INSERT INTO kemri_programs SET cidpid = ?, programme = ?, departmentId = ?, sectionId = ?, needsPriorities = ?, strategies = ?, objectives = ?, outcomes = ?, remarks = ?',
                        [
                            planCidpId, programName, departmentId, sectionId,
                            processedRow['Program_NeedsPriorities'], processedRow['Program_Strategies'],
                            processedRow['Program_Objectives'], processedRow['Program_Outcomes'], processedRow['Program_Remarks']
                        ]
                    );
                    programId = insertResult.insertId;
                    importSummary.programsCreated++;
                }

                if (programId && processedRow['Subprogram_Name']) {
                    const [existingSubprograms] = await connection.query('SELECT subProgramId FROM kemri_subprograms WHERE subProgramme = ? AND programId = ?', [processedRow['Subprogram_Name'], programId]);
                    if (existingSubprograms.length > 0) {
                        await connection.query(
                            `UPDATE kemri_subprograms SET keyOutcome = ?, kpi = ?, baseline = ?,
                             yr1Targets = ?, yr2Targets = ?, yr3Targets = ?, yr4Targets = ?, yr5Targets = ?,
                             yr1Budget = ?, yr2Budget = ?, yr3Budget = ?, yr4Budget = ?, yr5Budget = ?,
                             totalBudget = ?, remarks = ?
                             WHERE subProgramId = ?`,
                            [
                                processedRow['Subprogram_KeyOutcome'], processedRow['Subprogram_KPI'], processedRow['Subprogram_Baseline'],
                                processedRow['Subprogram_Yr1Targets'], processedRow['Subprogram_Yr2Targets'], processedRow['Subprogram_Yr3Targets'],
                                processedRow['Subprogram_Yr4Targets'], processedRow['Subprogram_Yr5Targets'],
                                processedRow['Subprogram_Yr1Budget'], processedRow['Subprogram_Yr2Budget'], processedRow['Subprogram_Yr3Budget'],
                                processedRow['Subprogram_Yr4Budget'], processedRow['Subprogram_Yr5Budget'],
                                processedRow['Subprogram_TotalBudget'], processedRow['Subprogram_Remarks'],
                                existingSubprograms[0].subProgramId
                            ]
                        );
                        importSummary.subprogramsUpdated++;
                    } else {
                        await connection.query(
                            `INSERT INTO kemri_subprograms SET programId = ?, subProgramme = ?, keyOutcome = ?, kpi = ?, baseline = ?,
                             yr1Targets = ?, yr2Targets = ?, yr3Targets = ?, yr4Targets = ?, yr5Targets = ?,
                             yr1Budget = ?, yr2Budget = ?, yr3Budget = ?, yr4Budget = ?, yr5Budget = ?,
                             totalBudget = ?, remarks = ?, voided = 0`,
                            [
                                programId, processedRow['Subprogram_Name'], processedRow['Subprogram_KeyOutcome'], processedRow['Subprogram_KPI'], processedRow['Subprogram_Baseline'],
                                processedRow['Subprogram_Yr1Targets'], processedRow['Subprogram_Yr2Targets'], processedRow['Subprogram_Yr3Targets'],
                                processedRow['Subprogram_Yr4Targets'], processedRow['Subprogram_Yr5Targets'],
                                processedRow['Subprogram_Yr1Budget'], processedRow['Subprogram_Yr2Budget'], processedRow['Subprogram_Yr3Budget'],
                                processedRow['Subprogram_Yr4Budget'], processedRow['Subprogram_Yr5Budget'],
                                processedRow['Subprogram_TotalBudget'], processedRow['Subprogram_Remarks']
                            ]
                        );
                        importSummary.subprogramsCreated++;
                    }
                } else {
                    throw new Error('Subprogram_Name or Program ID missing for a row.');
                }

            } catch (rowError) {
                importSummary.errors.push(`Row ${dataToImport.indexOf(row) + 2}: ${rowError.message}`);
                console.error(`Error processing row during confirmation:`, row, rowError);
            }
        }

        if (importSummary.errors.length > 0) {
            await connection.rollback();
            return res.status(400).json({
                success: false,
                message: `Import completed with ${importSummary.errors.length} errors. All changes rolled back.`,
                details: importSummary.errors
            });
        }

        await connection.commit();

        res.status(200).json({
            success: true,
            message: 'Data imported successfully!',
            details: importSummary
        });

    } catch (error) {
        if (connection) {
            await connection.rollback();
        }
        console.error('Overall import confirmation failed:', error);
        res.status(500).json({ success: false, message: `Import confirmation failed: ${error.message}` });
    } finally {
        if (connection) {
            connection.release();
        }
    }
});


// --- NEW: PDF Download Methods ---
router.get('/strategic_plans/:planId/export-pdf', async (req, res) => {
    const { planId } = req.params;
    let connection;
    try {
        connection = await pool.getConnection();
        const [planRows] = await connection.query('SELECT * FROM kemri_strategicPlans WHERE id = ?', [planId]);
        if (planRows.length === 0) {
            return res.status(404).json({ message: 'Strategic plan not found.' });
        }
        const plan = planRows[0];
        const [programs] = await connection.query('SELECT programId, programme, needsPriorities, strategies, objectives, outcomes, remarks FROM kemri_programs WHERE cidpid = ?', [plan.cidpid]);
        const subprogramPromises = programs.map(p =>
            connection.query('SELECT subProgramme, keyOutcome, kpi, baseline, yr1Targets, yr2Targets, yr3Targets, yr4Targets, yr5Targets, yr1Budget, yr2Budget, yr3Budget, yr4Budget, yr5Budget, totalBudget, remarks FROM kemri_subprograms WHERE programId = ?', [p.programId])
        );
        const subprogramResults = await Promise.all(subprogramPromises);
        programs.forEach((p, index) => {
            p.subprograms = subprogramResults[index][0];
        });

        const doc = new PDFDocument();
        const filename = `Strategic_Plan_Report_${plan.cidpName.replace(/\s/g, '_')}.pdf`;
        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
        doc.pipe(res);
        
        doc.fontSize(20).text(`Strategic Plan Report: ${plan.cidpName}`, { align: 'center' });
        doc.moveDown(0.5);
        doc.fontSize(14).text(`Plan ID: ${plan.cidpid}`);
        doc.fontSize(14).text(`Dates: ${plan.startDate} to ${plan.endDate}`);
        
        if (plan.strategicGoal) {
            doc.moveDown();
            doc.fontSize(16).text('Strategic Goal:', { underline: true });
            doc.moveDown(0.2);
            doc.fontSize(12).text(plan.strategicGoal);
        }
        doc.moveDown(1);
        if (programs && programs.length > 0) {
            doc.fontSize(16).text('Programs & Subprograms:', { underline: true });
            programs.forEach(p => {
                if (doc.y + 150 > doc.page.height - doc.page.margins.bottom) {
                    doc.addPage();
                }
                doc.moveDown(0.5);
                doc.fontSize(14).text(`- Program: ${p.programme}`);
                
                const addMultiLineText = (text, label, indent = 2) => {
                    if (text) {
                        doc.moveDown(0.2);
                        doc.fontSize(12).text(`${' '.repeat(indent)}- ${label}:`);
                        const bulletX = doc.page.margins.left + (indent * doc.fontSize() * 0.5) + (2 * doc.fontSize() * 0.5); 
                        const items = String(text).split('\n').filter(item => item.trim() !== '');
                        items.forEach(item => {
                            doc.text(`• ${item}`, bulletX, doc.y, { width: doc.page.width - bulletX - doc.page.margins.right });
                        });
                    } else {
                        doc.moveDown(0.2);
                        doc.fontSize(12).text(`${' '.repeat(indent)}- ${label}: N/A`);
                    }
                };
                addMultiLineText(p.needsPriorities, 'Needs & Priorities');
                addMultiLineText(p.strategies, 'Strategies');
                addMultiLineText(p.objectives, 'Objectives');
                addMultiLineText(p.outcomes, 'Outcomes');
                addMultiLineText(p.remarks, 'Remarks');
                
                if (p.subprograms && p.subprograms.length > 0) {
                    doc.moveDown(0.2);
                    doc.fontSize(12).text(`  - Subprograms:`);
                    p.subprograms.forEach((s, index) => {
                        doc.moveDown(0.5);
                        doc.fontSize(14).text(`    • Subprogram: ${s.subProgramme}`);
                        doc.fontSize(12).text(`      - KPI: ${s.kpi || 'N/A'}, Baseline: ${s.baseline || 'N/A'}`);
                        const totalBudget = parseFloat(s.totalBudget) || 0;
                        doc.fontSize(12).text(`      - Total Budget: ${formatCurrencyForPdf(s.totalBudget)}`);
                        
                        const budgetsTable = {
                            headers: ['Year 1', 'Year 2', 'Year 3', 'Year 4', 'Year 5'],
                            rows: [[
                                formatCurrencyForPdf(s.yr1Budget), 
                                formatCurrencyForPdf(s.yr2Budget), 
                                formatCurrencyForPdf(s.yr3Budget), 
                                formatCurrencyForPdf(s.yr4Budget), 
                                formatCurrencyForPdf(s.yr5Budget)
                            ]]
                        };
                        doc.moveDown(0.2);
                        doc.fontSize(8).text('      Yearly Budgets:');
                        const subprogramContentStartX = doc.x; 
                        drawTable(doc, budgetsTable, subprogramContentStartX, doc.y, { columnsSize: [70, 70, 70, 70, 70] });
                        doc.moveDown(0.1);
                        
                        const targetsTable = {
                            headers: ['Year 1', 'Year 2', 'Year 3', 'Year 4', 'Year 5'],
                            rows: [[s.yr1Targets || 'N/A', s.yr2Targets || 'N/A', s.yr3Targets || 'N/A', s.yr4Targets || 'N/A', s.yr5Targets || 'N/A']]
                        };
                        doc.moveDown(0.2);
                        doc.fontSize(8).text('      Yearly Targets:');
                        doc.x = subprogramContentStartX; 
                        drawTable(doc, targetsTable, doc.x, doc.y, { columnsSize: [70, 70, 70, 70, 70] });
                        
                        doc.x = doc.page.margins.left + (4 * doc.fontSize() * 0.5) + (2 * doc.fontSize() * 0.5); 
                        
                        addMultiLineText(s.keyOutcome, 'Key Outcome', 4);
                        addMultiLineText(s.remarks, 'Remarks', 4);

                        if (index < p.subprograms.length - 1) {
                            doc.moveDown(0.5);
                        }
                    });
                }
                doc.moveDown();
                doc.lineWidth(0.5).moveTo(doc.page.margins.left, doc.y).lineTo(doc.page.width - doc.page.margins.right, doc.y).stroke();
                doc.moveDown();
            });
        } else {
            doc.fontSize(12).text('No programs associated with this plan.');
        }

        doc.end();
    } catch (error) {
        console.error('Error generating PDF report:', error);
        res.status(500).json({ message: 'Failed to generate PDF report.', error: error.message });
    } finally {
        if (connection) connection.release();
    }
});

router.get('/programs/:programId/export-pdf', async (req, res) => {
    const { programId } = req.params;
    let connection;

    try {
        connection = await pool.getConnection();

        const [programRows] = await connection.query('SELECT programId, programme, needsPriorities, strategies, objectives, outcomes, remarks FROM kemri_programs WHERE programId = ?', [programId]);
        if (programRows.length === 0) {
            return res.status(404).json({ message: 'Program not found.' });
        }
        const program = programRows[0];

        const [subprograms] = await connection.query('SELECT subProgramme, keyOutcome, kpi, baseline, yr1Targets, yr2Targets, yr3Targets, yr4Targets, yr5Targets, yr1Budget, yr2Budget, yr3Budget, yr4Budget, yr5Budget, totalBudget, remarks FROM kemri_subprograms WHERE programId = ?', [programId]);

        const doc = new PDFDocument({ margin: 50 });
        const filename = `Program_Report_${program.programme.replace(/\s/g, '_')}.pdf`;

        res.setHeader('Content-Type', 'application/pdf');
        res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
        
        doc.pipe(res);

        doc.fontSize(20).text(`Program Report: ${program.programme}`, { align: 'center' });
        doc.moveDown(1);
        
        doc.fontSize(16).text('Program Details:', { underline: true });
        doc.moveDown(0.5);
        
        const addMultiLineText = (text, label, indent = 0) => {
            if (text && text.trim() !== '') {
                doc.moveDown(0.3);
                doc.fontSize(12).text(`${' '.repeat(indent)}- ${label}:`);
                
                const indentPx = indent * 10;
                const bulletX = doc.page.margins.left + indentPx + 20;
                const maxWidth = doc.page.width - bulletX - doc.page.margins.right;
                
                const items = String(text).split('\n').filter(item => item.trim() !== '');
                items.forEach(item => {
                    if (item.trim()) {
                        if (doc.y > doc.page.height - 100) {
                            doc.addPage();
                        }
                        doc.text(`• ${item.trim()}`, bulletX, doc.y, { 
                            width: maxWidth,
                            align: 'left'
                        });
                        doc.moveDown(0.2);
                    }
                });
            } else {
                doc.moveDown(0.3);
                doc.fontSize(12).text(`${' '.repeat(indent)}- ${label}: N/A`);
            }
        };
        
        addMultiLineText(program.needsPriorities, 'Needs & Priorities');
        addMultiLineText(program.strategies, 'Strategies');
        addMultiLineText(program.objectives, 'Objectives');
        addMultiLineText(program.outcomes, 'Outcomes');
        addMultiLineText(program.remarks, 'Remarks');
        
        doc.moveDown(1);

        doc.fontSize(16).text('Associated Subprograms:', { underline: true });
        doc.moveDown(0.5);
        
        if (subprograms && subprograms.length > 0) {
            subprograms.forEach((s, index) => {
                if (doc.y > doc.page.height - 200) {
                    doc.addPage();
                }
                
                doc.moveDown(0.5);
                doc.fontSize(14).text(`${index + 1}. Subprogram: ${s.subProgramme}`);
                doc.fontSize(12);
                
                doc.text(`   KPI: ${s.kpi || 'N/A'}`);
                doc.text(`   Baseline: ${s.baseline || 'N/A'}`);
                doc.text(`   Total Budget: ${formatCurrencyForPdf(s.totalBudget)}`);
                
                doc.moveDown(0.5);
                
                doc.fontSize(12).text('   Yearly Budgets:');
                doc.moveDown(0.2);
                
                const budgetTableY = doc.y;
                const tableStartX = doc.page.margins.left + 30;
                const colWidth = 80;
                
                doc.fontSize(10);
                const headers = ['Year 1', 'Year 2', 'Year 3', 'Year 4', 'Year 5'];
                headers.forEach((header, i) => {
                    doc.text(header, tableStartX + (i * colWidth), budgetTableY, { 
                        width: colWidth - 5,
                        align: 'center'
                    });
                });
                
                const budgetData = [
                    formatCurrencyForPdf(s.yr1Budget),
                    formatCurrencyForPdf(s.yr2Budget),
                    formatCurrencyForPdf(s.yr3Budget),
                    formatCurrencyForPdf(s.yr4Budget),
                    formatCurrencyForPdf(s.yr5Budget)
                ];
                
                const dataY = budgetTableY + 20;
                budgetData.forEach((data, i) => {
                    doc.text(data, tableStartX + (i * colWidth), dataY, {
                        width: colWidth - 5,
                        align: 'center'
                    });
                });
                
                doc.y = dataY + 25;
                
                doc.fontSize(12).text('   Yearly Targets:');
                doc.moveDown(0.2);
                
                const targetsTableY = doc.y;
                
                doc.fontSize(10);
                headers.forEach((header, i) => {
                    doc.text(header, tableStartX + (i * colWidth), targetsTableY, { 
                        width: colWidth - 5,
                        align: 'center'
                    });
                });
                
                const targetsData = [
                    s.yr1Targets || 'N/A',
                    s.yr2Targets || 'N/A',
                    s.yr3Targets || 'N/A',
                    s.yr4Targets || 'N/A',
                    s.yr5Targets || 'N/A'
                ];
                
                const targetsDataY = targetsTableY + 20;
                targetsData.forEach((data, i) => {
                    doc.text(String(data), tableStartX + (i * colWidth), targetsDataY, {
                        width: colWidth - 5,
                        align: 'center'
                    });
                });
                
                doc.y = targetsDataY + 25;
                
                addMultiLineText(s.keyOutcome, 'Key Outcome', 1);
                addMultiLineText(s.remarks, 'Remarks', 1);
                
                if (index < subprograms.length - 1) {
                    doc.moveDown(0.5);
                    doc.moveTo(doc.page.margins.left, doc.y)
                       .lineTo(doc.page.width - doc.page.margins.right, doc.y)
                       .stroke();
                    doc.moveDown(0.5);
                }
            });
        } else {
            doc.fontSize(12).text('No subprograms associated with this program.');
        }

        doc.end();

    } catch (error) {
        console.error('Error generating PDF report:', error);
        
        if (!res.headersSent) {
            res.status(500).json({ 
                message: 'Failed to generate PDF report.', 
                error: error.message 
            });
        }
    } finally {
        if (connection) {
            connection.release();
        }
    }
});


module.exports = router;