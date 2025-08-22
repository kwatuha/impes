const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const auth = require('../middleware/authenticate');
const privilege = require('../middleware/privilegeMiddleware');

// Helper function to format dates for MySQL (YYYY-MM-DD)
const formatDate = (dateString) => {
  if (!dateString) return null;
  return new Date(dateString).toISOString().slice(0, 10);
};

// --- Employee Management ---
router.get('/employees', auth, privilege(['employee.read_all']), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_staff WHERE voided = 0');
        res.json(rows);
    } catch (err) {
        console.error('Error fetching employees:', err);
        res.status(500).send('Error fetching employees');
    }
});

router.post('/employees', auth, privilege(['employee.create']), async (req, res) => {
    const { firstName, lastName, email, phoneNumber, departmentId, title, userId, gender, dateOfBirth, employmentStatus, startDate, emergencyContactName, emergencyContactPhone, nationality, maritalStatus, employmentType, managerId, role } = req.body;
    const sql = 'INSERT INTO kemri_staff (firstName, lastName, email, phoneNumber, departmentId, title, userId, gender, dateOfBirth, employmentStatus, startDate, emergencyContactName, emergencyContactPhone, nationality, maritalStatus, employmentType, managerId, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    try {
        const [result] = await pool.query(sql, [firstName, lastName, email, phoneNumber, departmentId, title, userId, gender, formatDate(dateOfBirth), employmentStatus, formatDate(startDate), emergencyContactName, emergencyContactPhone, nationality, maritalStatus, employmentType, managerId, role]);
        res.status(201).json({ staffId: result.insertId, message: 'Employee added successfully' });
    } catch (err) {
        console.error('Error adding employee:', err);
        res.status(500).send('Error adding employee');
    }
});

router.put('/employees/:id', auth, privilege(['employee.update']), async (req, res) => {
    const { id } = req.params;
    const { firstName, lastName, email, phoneNumber, departmentId, title, userId, gender, dateOfBirth, employmentStatus, startDate, emergencyContactName, emergencyContactPhone, nationality, maritalStatus, employmentType, managerId, role } = req.body;
    const sql = 'UPDATE kemri_staff SET firstName = ?, lastName = ?, email = ?, phoneNumber = ?, departmentId = ?, title = ?, userId = ?, gender = ?, dateOfBirth = ?, employmentStatus = ?, startDate = ?, emergencyContactName = ?, emergencyContactPhone = ?, nationality = ?, maritalStatus = ?, employmentType = ?, managerId = ?, role = ?, updatedAt = CURRENT_TIMESTAMP WHERE staffId = ?';
    try {
        const [result] = await pool.query(sql, [firstName, lastName, email, phoneNumber, departmentId, title, userId, gender, formatDate(dateOfBirth), employmentStatus, formatDate(startDate), emergencyContactName, emergencyContactPhone, nationality, maritalStatus, employmentType, managerId, role, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Employee not found.' });
        }
        res.status(200).json({ message: 'Employee updated successfully' });
    } catch (err) {
        console.error('Error updating employee:', err);
        res.status(500).send('Error updating employee');
    }
});

router.delete('/employees/:id', auth, privilege(['employee.delete']), async (req, res) => {
    const { id } = req.params;
    const sql = 'UPDATE kemri_staff SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE staffId = ?';
    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Employee not found.' });
        }
        res.status(200).json({ message: 'Employee deleted successfully' });
    } catch (err) {
        console.error('Error deleting employee:', err);
        res.status(500).send('Error deleting employee');
    }
});

// --- Employee 360 View ---
router.get('/employees/:id/360', auth, privilege(['employee.read_all', 'employee.read_360']), async (req, res) => {
    const { id } = req.params;
    try {
        const [employeeRows] = await pool.query('SELECT * FROM kemri_staff WHERE staffId = ? AND voided = 0', [id]);
        if (employeeRows.length === 0) {
            return res.status(404).json({ message: 'Employee not found.' });
        }
        const profile = employeeRows[0];

        const dataPromises = [
            pool.query('SELECT * FROM kemri_employee_performance WHERE staffId = ? AND voided = 0 ORDER BY reviewDate DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_compensation WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_training WHERE staffId = ? AND voided = 0 ORDER BY completionDate DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_disciplinary WHERE staffId = ? AND voided = 0 ORDER BY actionDate DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_contracts WHERE staffId = ? AND voided = 0 ORDER BY contractStartDate DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_retirements WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_loans WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_monthly_payroll WHERE staffId = ? AND voided = 0 ORDER BY payPeriod DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_dependants WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_terminations WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_bank_details WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_memberships WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_benefits WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_assigned_assets WHERE staffId = ? AND voided = 0', [id]),
            pool.query('SELECT * FROM kemri_employee_promotions WHERE staffId = ? AND voided = 0 ORDER BY promotionDate DESC', [id]),
            pool.query('SELECT * FROM kemri_employee_project_assignments WHERE staffId = ? AND voided = 0', [id]),
            pool.query(`
                SELECT 
                    la.*, 
                    lt.name as leaveTypeName,
                    hs.firstName AS handoverFirstName,
                    hs.lastName AS handoverLastName
                FROM kemri_leave_applications la 
                JOIN kemri_leave_types lt ON la.leaveTypeId = lt.id
                LEFT JOIN kemri_staff hs ON la.handoverStaffId = hs.staffId 
                WHERE la.staffId = ? AND la.voided = 0 
                ORDER BY la.startDate DESC
            `, [id]),
            pool.query('SELECT * FROM kemri_job_groups WHERE voided = 0')
        ];

        const results = await Promise.all(dataPromises);

        res.json({
            profile: profile,
            performanceReviews: results[0][0],
            compensations:      results[1][0],
            trainings:          results[2][0],
            disciplinaries:     results[3][0],
            contracts:          results[4][0],
            retirements:        results[5][0],
            loans:              results[6][0],
            payrolls:           results[7][0],
            dependants:         results[8][0],
            terminations:       results[9][0],
            bankDetails:        results[10][0],
            memberships:        results[11][0],
            benefits:           results[12][0],
            assignedAssets:     results[13][0],
            promotions:         results[14][0],
            projectAssignments: results[15][0],
            leaveApplications:  results[16][0],
            jobGroups:          results[17][0],
        });

    } catch (err) {
        console.error('Error fetching employee 360 view:', err);
        res.status(500).send('Error fetching employee 360 view');
    }
});

// --- Performance Management ---
router.post('/employees/performance', auth, privilege(['employee.performance.create']), async (req, res) => {
    const { staffId, reviewDate, reviewScore, comments, reviewerId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_performance (staffId, reviewDate, reviewScore, comments, reviewerId) VALUES (?, ?, ?, ?, ?)', [staffId, formatDate(reviewDate), reviewScore, comments, reviewerId]);
        res.status(201).json({ id: result.insertId, message: 'Performance review added successfully' });
    } catch (err) {
        console.error('Error adding performance review:', err);
        res.status(500).send('Error adding performance review');
    }
});

router.put('/employees/performance/:id', auth, privilege(['employee.performance.update']), async (req, res) => {
    const { id } = req.params;
    const { reviewDate, reviewScore, comments, reviewerId } = req.body;
    const sql = 'UPDATE kemri_employee_performance SET reviewDate = ?, reviewScore = ?, comments = ?, reviewerId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [formatDate(reviewDate), reviewScore, comments, reviewerId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Performance review not found.' });
        }
        res.status(200).json({ message: 'Performance review updated successfully' });
    } catch (err) {
        console.error('Error updating performance review:', err);
        res.status(500).send('Error updating performance review');
    }
});

router.delete('/employees/performance/:id', auth, privilege(['employee.performance.delete']), async (req, res) => {
    const { id } = req.params;
    const sql = 'UPDATE kemri_employee_performance SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Performance review not found.' });
        }
        res.status(200).json({ message: 'Performance review deleted successfully' });
    } catch (err) {
        console.error('Error deleting performance review:', err);
        res.status(500).send('Error deleting performance review');
    }
});

// --- Leave Types Management ---
router.get('/leave-types', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_leave_types WHERE voided = 0');
        res.json(rows);
    } catch (err) {
        console.error('Error fetching leave types:', err);
        res.status(500).send('Error fetching leave types');
    }
});

router.post('/leave-types', auth, privilege(['leave.type.create']), async (req, res) => {
    const { name, description, numberOfDays, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_leave_types (name, description, numberOfDays, userId) VALUES (?, ?, ?, ?)', [name, description, numberOfDays, userId]);
        res.status(201).json({ id: result.insertId, message: 'Leave type added successfully' });
    } catch (err) {
        console.error('Error adding leave type:', err);
        res.status(500).send('Error adding leave type');
    }
});

router.put('/leave-types/:id', auth, privilege(['leave.type.update']), async (req, res) => {
    const { id } = req.params;
    const { name, description, numberOfDays, userId } = req.body;
    const sql = 'UPDATE kemri_leave_types SET name = ?, description = ?, numberOfDays = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [name, description, numberOfDays, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave type not found.' });
        }
        res.status(200).json({ message: 'Leave type updated successfully' });
    } catch (err) {
        console.error('Error updating leave type:', err);
        res.status(500).send('Error updating leave type');
    }
});

router.delete('/leave-types/:id', auth, privilege(['leave.type.delete']), async (req, res) => {
    const { id } = req.params;
    const sql = 'UPDATE kemri_leave_types SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave type not found.' });
        }
        res.status(200).json({ message: 'Leave type deleted successfully' });
    } catch (err) {
        console.error('Error deleting leave type:', err);
        res.status(500).send('Error deleting leave type');
    }
});


// --- Leave Application Management ---
router.get('/leave-applications', auth, privilege(['leave.read_all']), async (req, res) => {
    const sql = `
        SELECT la.id, la.staffId, la.leaveTypeId, la.handoverStaffId, la.startDate, la.endDate, la.numberOfDays, la.reason, la.handoverComments, la.status, la.approvedStartDate, la.approvedEndDate, la.actualReturnDate, s.firstName, s.lastName, lt.name AS leaveTypeName, hs.firstName AS handoverFirstName, hs.lastName AS handoverLastName
        FROM kemri_leave_applications la JOIN kemri_staff s ON la.staffId = s.staffId JOIN kemri_leave_types lt ON la.leaveTypeId = lt.id LEFT JOIN kemri_staff hs ON la.handoverStaffId = hs.staffId
        WHERE la.voided = 0 ORDER BY la.createdAt DESC
    `;
    try {
        const [rows] = await pool.query(sql);
        res.json(rows);
    } catch (err) {
        console.error('Error fetching leave applications:', err);
        res.status(500).send('Error fetching leave applications');
    }
});

router.post('/leave-applications', auth, privilege(['leave.apply']), async (req, res) => {
    const { staffId, leaveTypeId, startDate, endDate, numberOfDays, reason, handoverStaffId, handoverComments, userId } = req.body;
    const sql = 'INSERT INTO kemri_leave_applications (staffId, leaveTypeId, startDate, endDate, numberOfDays, reason, handoverStaffId, handoverComments, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
    try {
        const [result] = await pool.query(sql, [staffId, leaveTypeId, formatDate(startDate), formatDate(endDate), numberOfDays, reason, handoverStaffId, handoverComments, userId]);
        res.status(201).json({ id: result.insertId, message: 'Leave application submitted' });
    } catch (err) {
        console.error('Error submitting leave application:', err);
        res.status(500).send('Error submitting leave application');
    }
});

router.put('/leave-applications/:id', auth, privilege(['leave.approve']), async (req, res) => {
    const { status, approvedStartDate, approvedEndDate, userId } = req.body;
    const { id } = req.params;

    let sql, params;
    if (status === 'Approved') {
        sql = 'UPDATE kemri_leave_applications SET status = ?, approvedStartDate = ?, approvedEndDate = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
        params = [status, formatDate(approvedStartDate), formatDate(approvedEndDate), userId, id];
    } else {
        sql = 'UPDATE kemri_leave_applications SET status = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
        params = [status, userId, id];
    }

    try {
        await pool.query(sql, params);
        res.status(200).json({ message: 'Leave status updated successfully' });
    } catch (err) {
        console.error('Error updating leave status:', err);
        res.status(500).send('Error updating leave status');
    }
});

router.put('/leave-applications/:id/edit', auth, privilege(['leave.update']), async (req, res) => {
    const { staffId, leaveTypeId, startDate, endDate, numberOfDays, reason, handoverStaffId, handoverComments, userId } = req.body;
    const { id } = req.params;
    const sql = 'UPDATE kemri_leave_applications SET staffId = ?, leaveTypeId = ?, startDate = ?, endDate = ?, numberOfDays = ?, reason = ?, handoverStaffId = ?, handoverComments = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [staffId, leaveTypeId, formatDate(startDate), formatDate(endDate), numberOfDays, reason, handoverStaffId, handoverComments, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave application not found.' });
        }
        res.status(200).json({ message: 'Leave application updated successfully' });
    } catch (err) {
        console.error('Error updating leave application:', err);
        res.status(500).send('Error updating leave application');
    }
});

router.put('/leave-applications/:id/return', auth, privilege(['leave.complete']), async (req, res) => {
    const { actualReturnDate, userId } = req.body;
    const { id } = req.params;
    const sql = 'UPDATE kemri_leave_applications SET actualReturnDate = ?, status = "Completed", userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        await pool.query(sql, [formatDate(actualReturnDate), userId, id]);
        res.status(200).json({ message: 'Actual return date recorded successfully' });
    } catch (err) {
        console.error('Error recording actual return date:', err);
        res.status(500).send('Error recording actual return date');
    }
});

router.delete('/leave-applications/:id', auth, privilege(['leave.delete']), async (req, res) => {
    const { id } = req.params;
    const sql = 'UPDATE kemri_leave_applications SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
    try {
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave application not found.' });
        }
        res.status(200).json({ message: 'Leave application deleted successfully' });
    } catch (err) {
        console.error('Error deleting leave application:', err);
        res.status(500).send('Error deleting leave application');
    }
});


// --- Attendance Management ---
router.get('/attendance/today', auth, privilege(['attendance.read_all']), async (req, res) => {
    const sql = `
        SELECT id, staffId, date, checkInTime, checkOutTime, userId, createdAt, updatedAt FROM kemri_attendance
        WHERE date = CURDATE() AND voided = 0 ORDER BY checkInTime DESC
    `;
    try {
        const [rows] = await pool.query(sql);
        res.json(rows);
    } catch (err) {
        console.error("Error fetching today's attendance:", err);
        res.status(500).send("Error fetching today's attendance");
    }
});

router.post('/attendance/check-in', auth, privilege(['attendance.create']), async (req, res) => {
    const { staffId, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_attendance (staffId, date, checkInTime, userId) VALUES (?, CURDATE(), NOW(), ?)', [staffId, userId]);
        res.status(201).json({ id: result.insertId, message: 'Check-in recorded successfully' });
    } catch (err) {
        console.error('Error recording check-in:', err);
        res.status(500).send('Error recording check-in');
    }
});

router.put('/attendance/check-out/:id', auth, privilege(['attendance.create']), async (req, res) => {
    const { id } = req.params;
    const { userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_attendance SET checkOutTime = NOW(), userId = ?, updatedAt = NOW() WHERE id = ?', [userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).send('Attendance record not found.');
        }
        res.status(200).json({ message: 'Check-out recorded successfully' });
    } catch (err) {
        console.error('Error recording check-out:', err);
        res.status(500).send('Error recording check-out');
    }
});

// --- Employee Compensation ---
router.post('/employee-compensation', auth, privilege(['compensation.create']), async (req, res) => {
    const { staffId, baseSalary, allowances, bonuses, bankName, accountNumber, payFrequency, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_compensation (staffId, baseSalary, allowances, bonuses, bankName, accountNumber, payFrequency, userId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [staffId, baseSalary, allowances, bonuses, bankName, accountNumber, payFrequency, userId]);
        res.status(201).json({ id: result.insertId, message: 'Compensation record added successfully' });
    } catch (err) {
        console.error('Error adding compensation record:', err);
        res.status(500).send('Error adding compensation record');
    }
});

router.put('/employee-compensation/:id', auth, privilege(['compensation.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, baseSalary, allowances, bonuses, bankName, accountNumber, payFrequency, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_compensation SET staffId = ?, baseSalary = ?, allowances = ?, bonuses = ?, bankName = ?, accountNumber = ?, payFrequency = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, baseSalary, allowances, bonuses, bankName, accountNumber, payFrequency, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Compensation record not found.' });
        }
        res.status(200).json({ message: 'Compensation record updated successfully' });
    } catch (err) {
        console.error('Error updating compensation record:', err);
        res.status(500).send('Error updating compensation record');
    }
});

router.delete('/employee-compensation/:id', auth, privilege(['compensation.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_compensation SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Compensation record not found.' });
        }
        res.status(200).json({ message: 'Compensation record deleted successfully' });
    } catch (err) {
        console.error('Error deleting compensation record:', err);
        res.status(500).send('Error deleting compensation record');
    }
});

// --- Employee Training ---
router.post('/employee-training', auth, privilege(['training.create']), async (req, res) => {
    const { staffId, courseName, institution, certificationName, completionDate, expiryDate, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_training (staffId, courseName, institution, certificationName, completionDate, expiryDate, userId) VALUES (?, ?, ?, ?, ?, ?, ?)', [staffId, courseName, institution, certificationName, formatDate(completionDate), formatDate(expiryDate), userId]);
        res.status(201).json({ id: result.insertId, message: 'Training record added successfully' });
    } catch (err) {
        console.error('Error adding training record:', err);
        res.status(500).send('Error adding training record');
    }
});

router.put('/employee-training/:id', auth, privilege(['training.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, courseName, institution, certificationName, completionDate, expiryDate, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_training SET staffId = ?, courseName = ?, institution = ?, certificationName = ?, completionDate = ?, expiryDate = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, courseName, institution, certificationName, formatDate(completionDate), formatDate(expiryDate), userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Training record not found.' });
        }
        res.status(200).json({ message: 'Training record updated successfully' });
    } catch (err) {
        console.error('Error updating training record:', err);
        res.status(500).send('Error updating training record');
    }
});

router.delete('/employee-training/:id', auth, privilege(['training.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_training SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Training record not found.' });
        }
        res.status(200).json({ message: 'Training record deleted successfully' });
    } catch (err) {
        console.error('Error deleting training record:', err);
        res.status(500).send('Error deleting training record');
    }
});

// --- Job Groups ---
router.get('/job-groups', auth, privilege(['job_group.read_all']), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_job_groups WHERE voided = 0');
        res.json(rows);
    } catch (err) {
        console.error('Error fetching job groups:', err);
        res.status(500).send('Error fetching job groups');
    }
});

router.post('/job-groups', auth, privilege(['job_group.create']), async (req, res) => {
    const { groupName, salaryScale, description, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_job_groups (groupName, salaryScale, description, userId) VALUES (?, ?, ?, ?)', [groupName, salaryScale, description, userId]);
        res.status(201).json({ id: result.insertId, message: 'Job group added successfully' });
    } catch (err) {
        console.error('Error adding job group:', err);
        res.status(500).send('Error adding job group');
    }
});

router.put('/job-groups/:id', auth, privilege(['job_group.update']), async (req, res) => {
    const { id } = req.params;
    const { groupName, salaryScale, description, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_job_groups SET groupName = ?, salaryScale = ?, description = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [groupName, salaryScale, description, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Job group not found.' });
        }
        res.status(200).json({ message: 'Job group updated successfully' });
    } catch (err) {
        console.error('Error updating job group:', err);
        res.status(500).send('Error updating job group');
    }
});

router.delete('/job-groups/:id', auth, privilege(['job_group.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_job_groups SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Job group not found.' });
        }
        res.status(200).json({ message: 'Job group deleted successfully' });
    } catch (err) {
        console.error('Error deleting job group:', err);
        res.status(500).send('Error deleting job group');
    }
});

// --- Employee Promotions ---
router.post('/employee-promotions', auth, privilege(['promotion.create']), async (req, res) => {
    const { staffId, oldJobGroupId, newJobGroupId, promotionDate, comments, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_promotions (staffId, oldJobGroupId, newJobGroupId, promotionDate, comments, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, oldJobGroupId, newJobGroupId, formatDate(promotionDate), comments, userId]);
        res.status(201).json({ id: result.insertId, message: 'Promotion record added successfully' });
    } catch (err) {
        console.error('Error adding promotion record:', err);
        res.status(500).send('Error adding promotion record');
    }
});

router.put('/employee-promotions/:id', auth, privilege(['promotion.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, oldJobGroupId, newJobGroupId, promotionDate, comments, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_promotions SET staffId = ?, oldJobGroupId = ?, newJobGroupId = ?, promotionDate = ?, comments = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, oldJobGroupId, newJobGroupId, formatDate(promotionDate), comments, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Promotion record not found.' });
        }
        res.status(200).json({ message: 'Promotion record updated successfully' });
    } catch (err) {
        console.error('Error updating promotion record:', err);
        res.status(500).send('Error updating promotion record');
    }
});

router.delete('/employee-promotions/:id', auth, privilege(['promotion.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_promotions SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Promotion record not found.' });
        }
        res.status(200).json({ message: 'Promotion record deleted successfully' });
    } catch (err) {
        console.error('Error deleting promotion record:', err);
        res.status(500).send('Error deleting promotion record');
    }
});

// --- Employee Disciplinary ---
router.post('/employee-disciplinary', auth, privilege(['disciplinary.create']), async (req, res) => {
    const { staffId, actionType, actionDate, reason, comments, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_disciplinary (staffId, actionType, actionDate, reason, comments, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, actionType, formatDate(actionDate), reason, comments, userId]);
        res.status(201).json({ id: result.insertId, message: 'Disciplinary action added successfully' });
    } catch (err) {
        console.error('Error adding disciplinary action:', err);
        res.status(500).send('Error adding disciplinary action');
    }
});

router.put('/employee-disciplinary/:id', auth, privilege(['disciplinary.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, actionType, actionDate, reason, comments, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_disciplinary SET staffId = ?, actionType = ?, actionDate = ?, reason = ?, comments = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, actionType, formatDate(actionDate), reason, comments, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Disciplinary record not found.' });
        }
        res.status(200).json({ message: 'Disciplinary action updated successfully' });
    } catch (err) {
        console.error('Error updating disciplinary action:', err);
        res.status(500).send('Error updating disciplinary action');
    }
});

router.delete('/employee-disciplinary/:id', auth, privilege(['disciplinary.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_disciplinary SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Disciplinary record not found.' });
        }
        res.status(200).json({ message: 'Disciplinary action deleted successfully' });
    } catch (err) {
        console.error('Error deleting disciplinary action:', err);
        res.status(500).send('Error deleting disciplinary action');
    }
});

// --- Employee Contracts ---
router.post('/employee-contracts', auth, privilege(['contracts.create']), async (req, res) => {
    const { staffId, contractType, contractStartDate, contractEndDate, status, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_contracts (staffId, contractType, contractStartDate, contractEndDate, status, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, contractType, formatDate(contractStartDate), formatDate(contractEndDate), status, userId]);
        res.status(201).json({ id: result.insertId, message: 'Contract added successfully' });
    } catch (err) {
        console.error('Error adding contract:', err);
        res.status(500).send('Error adding contract');
    }
});

router.put('/employee-contracts/:id', auth, privilege(['contracts.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, contractType, contractStartDate, contractEndDate, status, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_contracts SET staffId = ?, contractType = ?, contractStartDate = ?, contractEndDate = ?, status = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, contractType, formatDate(contractStartDate), formatDate(contractEndDate), status, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Contract not found.' });
        }
        res.status(200).json({ message: 'Contract updated successfully' });
    } catch (err) {
        console.error('Error updating contract:', err);
        res.status(500).send('Error updating contract');
    }
});

router.delete('/employee-contracts/:id', auth, privilege(['contracts.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_contracts SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Contract not found.' });
        }
        res.status(200).json({ message: 'Contract deleted successfully' });
    } catch (err) {
        console.error('Error deleting contract:', err);
        res.status(500).send('Error deleting contract');
    }
});

// --- Employee Retirements ---
router.post('/employee-retirements', auth, privilege(['retirements.create']), async (req, res) => {
    const { staffId, retirementDate, retirementType, comments, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_retirements (staffId, retirementDate, retirementType, comments, userId) VALUES (?, ?, ?, ?, ?)', [staffId, formatDate(retirementDate), retirementType, comments, userId]);
        res.status(201).json({ id: result.insertId, message: 'Retirement record added successfully' });
    } catch (err) {
        console.error('Error adding retirement record:', err);
        res.status(500).send('Error adding retirement record');
    }
});

router.put('/employee-retirements/:id', auth, privilege(['retirements.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, retirementDate, retirementType, comments, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_retirements SET staffId = ?, retirementDate = ?, retirementType = ?, comments = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, formatDate(retirementDate), retirementType, comments, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Retirement record not found.' });
        }
        res.status(200).json({ message: 'Retirement record updated successfully' });
    } catch (err) {
        console.error('Error updating retirement record:', err);
        res.status(500).send('Error updating retirement record');
    }
});

router.delete('/employee-retirements/:id', auth, privilege(['retirements.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_retirements SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Retirement record not found.' });
        }
        res.status(200).json({ message: 'Retirement record deleted successfully' });
    } catch (err) {
        console.error('Error deleting retirement record:', err);
        res.status(500).send('Error deleting retirement record');
    }
});

// --- Employee Loans ---
router.post('/employee-loans', auth, privilege(['loans.create']), async (req, res) => {
    const { staffId, loanAmount, loanDate, status, repaymentSchedule, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_loans (staffId, loanAmount, loanDate, status, repaymentSchedule, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, loanAmount, formatDate(loanDate), status, repaymentSchedule, userId]);
        res.status(201).json({ id: result.insertId, message: 'Loan record added successfully' });
    } catch (err) {
        console.error('Error adding loan record:', err);
        res.status(500).send('Error adding loan record');
    }
});

router.put('/employee-loans/:id', auth, privilege(['loans.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, loanAmount, loanDate, status, repaymentSchedule, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_loans SET staffId = ?, loanAmount = ?, loanDate = ?, status = ?, repaymentSchedule = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, loanAmount, formatDate(loanDate), status, repaymentSchedule, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Loan record not found.' });
        }
        res.status(200).json({ message: 'Loan record updated successfully' });
    } catch (err) {
        console.error('Error updating loan record:', err);
        res.status(500).send('Error updating loan record');
    }
});

router.delete('/employee-loans/:id', auth, privilege(['loans.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_loans SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Loan record not found.' });
        }
        res.status(200).json({ message: 'Loan record deleted successfully' });
    } catch (err) {
        console.error('Error deleting loan record:', err);
        res.status(500).send('Error deleting loan record');
    }
});

// --- Monthly Payroll ---
router.post('/monthly-payroll', auth, privilege(['payroll.create']), async (req, res) => {
    const { staffId, payPeriod, grossSalary, netSalary, allowances, deductions, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_monthly_payroll (staffId, payPeriod, grossSalary, netSalary, allowances, deductions, userId) VALUES (?, ?, ?, ?, ?, ?, ?)', [staffId, formatDate(payPeriod), grossSalary, netSalary, allowances, deductions, userId]);
        res.status(201).json({ id: result.insertId, message: 'Payroll record added successfully' });
    } catch (err) {
        console.error('Error adding payroll record:', err);
        res.status(500).send('Error adding payroll record');
    }
});

router.put('/monthly-payroll/:id', auth, privilege(['payroll.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, payPeriod, grossSalary, netSalary, allowances, deductions, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_monthly_payroll SET staffId = ?, payPeriod = ?, grossSalary = ?, netSalary = ?, allowances = ?, deductions = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, formatDate(payPeriod), grossSalary, netSalary, allowances, deductions, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Payroll record not found.' });
        }
        res.status(200).json({ message: 'Payroll record updated successfully' });
    } catch (err) {
        console.error('Error updating payroll record:', err);
        res.status(500).send('Error updating payroll record');
    }
});

router.delete('/monthly-payroll/:id', auth, privilege(['payroll.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_monthly_payroll SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Payroll record not found.' });
        }
        res.status(200).json({ message: 'Payroll record deleted successfully' });
    } catch (err) {
        console.error('Error deleting payroll record:', err);
        res.status(500).send('Error deleting payroll record');
    }
});

// --- Employee Dependants ---
router.post('/employee-dependants', auth, privilege(['dependants.create']), async (req, res) => {
    const { staffId, dependantName, relationship, dateOfBirth, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_dependants (staffId, dependantName, relationship, dateOfBirth, userId) VALUES (?, ?, ?, ?, ?)', [staffId, dependantName, relationship, formatDate(dateOfBirth), userId]);
        res.status(201).json({ id: result.insertId, message: 'Dependant record added successfully' });
    } catch (err) {
        console.error('Error adding dependant record:', err);
        res.status(500).send('Error adding dependant record');
    }
});

router.put('/employee-dependants/:id', auth, privilege(['dependants.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, dependantName, relationship, dateOfBirth, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_dependants SET staffId = ?, dependantName = ?, relationship = ?, dateOfBirth = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, dependantName, relationship, formatDate(dateOfBirth), userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Dependant record not found.' });
        }
        res.status(200).json({ message: 'Dependant record updated successfully' });
    } catch (err) {
        console.error('Error updating dependant record:', err);
        res.status(500).send('Error updating dependant record');
    }
});

router.delete('/employee-dependants/:id', auth, privilege(['dependants.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_dependants SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Dependant record not found.' });
        }
        res.status(200).json({ message: 'Dependant record deleted successfully' });
    } catch (err) {
        console.error('Error deleting dependant record:', err);
        res.status(500).send('Error deleting dependant record');
    }
});

// --- Employee Terminations ---
router.post('/employee-terminations', auth, privilege(['terminations.create']), async (req, res) => {
    const { staffId, exitDate, reason, exitInterviewDetails, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_terminations (staffId, exitDate, reason, exitInterviewDetails, userId) VALUES (?, ?, ?, ?, ?)', [staffId, formatDate(exitDate), reason, exitInterviewDetails, userId]);
        res.status(201).json({ id: result.insertId, message: 'Termination record added successfully' });
    } catch (err) {
        console.error('Error adding termination record:', err);
        res.status(500).send('Error adding termination record');
    }
});

router.put('/employee-terminations/:id', auth, privilege(['terminations.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, exitDate, reason, exitInterviewDetails, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_terminations SET staffId = ?, exitDate = ?, reason = ?, exitInterviewDetails = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, formatDate(exitDate), reason, exitInterviewDetails, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Termination record not found.' });
        }
        res.status(200).json({ message: 'Termination record updated successfully' });
    } catch (err) {
        console.error('Error updating termination record:', err);
        res.status(500).send('Error updating termination record');
    }
});

router.delete('/employee-terminations/:id', auth, privilege(['terminations.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_terminations SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Termination record not found.' });
        }
        res.status(200).json({ message: 'Termination record deleted successfully' });
    } catch (err) {
        console.error('Error deleting termination record:', err);
        res.status(500).send('Error deleting termination record');
    }
});

// --- Employee Bank Details ---
router.post('/employee-bank-details', auth, privilege(['bank_details.create']), async (req, res) => {
    const { staffId, bankName, accountNumber, branchName, isPrimary, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_bank_details (staffId, bankName, accountNumber, branchName, isPrimary, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, bankName, accountNumber, branchName, isPrimary, userId]);
        res.status(201).json({ id: result.insertId, message: 'Bank details added successfully' });
    } catch (err) {
        console.error('Error adding bank details:', err);
        res.status(500).send('Error adding bank details');
    }
});

router.put('/employee-bank-details/:id', auth, privilege(['bank_details.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, bankName, accountNumber, branchName, isPrimary, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_bank_details SET staffId = ?, bankName = ?, accountNumber = ?, branchName = ?, isPrimary = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, bankName, accountNumber, branchName, isPrimary, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Bank details not found.' });
        }
        res.status(200).json({ message: 'Bank details updated successfully' });
    } catch (err) {
        console.error('Error updating bank details:', err);
        res.status(500).send('Error updating bank details');
    }
});

router.delete('/employee-bank-details/:id', auth, privilege(['bank_details.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_bank_details SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Bank details not found.' });
        }
        res.status(200).json({ message: 'Bank details deleted successfully' });
    } catch (err) {
        console.error('Error deleting bank details:', err);
        res.status(500).send('Error deleting bank details');
    }
});

// --- Employee Memberships ---
router.post('/employee-memberships', auth, privilege(['memberships.create']), async (req, res) => {
    const { staffId, organizationName, membershipNumber, startDate, endDate, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_memberships (staffId, organizationName, membershipNumber, startDate, endDate, userId) VALUES (?, ?, ?, ?, ?, ?)', [staffId, organizationName, membershipNumber, formatDate(startDate), formatDate(endDate), userId]);
        res.status(201).json({ id: result.insertId, message: 'Membership record added successfully' });
    } catch (err) {
        console.error('Error adding membership record:', err);
        res.status(500).send('Error adding membership record');
    }
});

router.put('/employee-memberships/:id', auth, privilege(['memberships.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, organizationName, membershipNumber, startDate, endDate, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_memberships SET staffId = ?, organizationName = ?, membershipNumber = ?, startDate = ?, endDate = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, organizationName, membershipNumber, formatDate(startDate), formatDate(endDate), userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Membership record not found.' });
        }
        res.status(200).json({ message: 'Membership record updated successfully' });
    } catch (err) {
        console.error('Error updating membership record:', err);
        res.status(500).send('Error updating membership record');
    }
});

router.delete('/employee-memberships/:id', auth, privilege(['memberships.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_memberships SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Membership record not found.' });
        }
        res.status(200).json({ message: 'Membership record deleted successfully' });
    } catch (err) {
        console.error('Error deleting membership record:', err);
        res.status(500).send('Error deleting membership record');
    }
});

// --- Employee Benefits ---
router.post('/employee-benefits', auth, privilege(['benefits.create']), async (req, res) => {
    const { staffId, benefitName, enrollmentDate, status, userId } = req.body;
    try {
        const [result] = await pool.query('INSERT INTO kemri_employee_benefits (staffId, benefitName, enrollmentDate, status, userId) VALUES (?, ?, ?, ?, ?)', [staffId, benefitName, formatDate(enrollmentDate), status, userId]);
        res.status(201).json({ id: result.insertId, message: 'Benefit record added successfully' });
    } catch (err) {
        console.error('Error adding benefit record:', err);
        res.status(500).send('Error adding benefit record');
    }
});

router.put('/employee-benefits/:id', auth, privilege(['benefits.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, benefitName, enrollmentDate, status, userId } = req.body;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_benefits SET staffId = ?, benefitName = ?, enrollmentDate = ?, status = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [staffId, benefitName, formatDate(enrollmentDate), status, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Benefit record not found.' });
        }
        res.status(200).json({ message: 'Benefit record updated successfully' });
    } catch (err) {
        console.error('Error updating benefit record:', err);
        res.status(500).send('Error updating benefit record');
    }
});

router.delete('/employee-benefits/:id', auth, privilege(['benefits.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_employee_benefits SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Benefit record not found.' });
        }
        res.status(200).json({ message: 'Benefit record deleted successfully' });
    } catch (err) {
        console.error('Error deleting benefit record:', err);
        res.status(500).send('Error deleting benefit record');
    }
});

// --- Assigned Assets ---
router.post('/assigned-assets', auth, privilege(['assets.create']), async (req, res) => {
    const { staffId, assetName, serialNumber, assignmentDate, returnDate, condition, userId } = req.body;
    try {
        const sql = 'INSERT INTO kemri_assigned_assets (staffId, assetName, serialNumber, assignmentDate, returnDate, `condition`, userId) VALUES (?, ?, ?, ?, ?, ?, ?)';
        const [result] = await pool.query(sql, [staffId, assetName, serialNumber, formatDate(assignmentDate), formatDate(returnDate), condition, userId]);
        res.status(201).json({ id: result.insertId, message: 'Asset assignment recorded successfully' });
    } catch (err) {
        console.error('Error adding asset assignment:', err);
        res.status(500).send('Error adding asset assignment');
    }
});

router.put('/assigned-assets/:id', auth, privilege(['assets.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, assetName, serialNumber, assignmentDate, returnDate, condition, userId } = req.body;
    try {
        const sql = 'UPDATE kemri_assigned_assets SET staffId = ?, assetName = ?, serialNumber = ?, assignmentDate = ?, returnDate = ?, `condition` = ?, userId = ?, updatedAt = CURRENT_TIMESTAMP WHERE id = ?';
        const [result] = await pool.query(sql, [staffId, assetName, serialNumber, formatDate(assignmentDate), formatDate(returnDate), condition, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Asset assignment not found.' });
        }
        res.status(200).json({ message: 'Asset assignment updated successfully' });
    } catch (err) {
        console.error('Error updating asset assignment:', err);
        res.status(500).send('Error updating asset assignment');
    }
});

router.delete('/assigned-assets/:id', auth, privilege(['assets.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('UPDATE kemri_assigned_assets SET voided = 1, updatedAt = CURRENT_TIMESTAMP WHERE id = ?', [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Asset assignment not found.' });
        }
        res.status(200).json({ message: 'Asset assignment deleted successfully' });
    } catch (err) {
        console.error('Error deleting asset assignment:', err);
        res.status(500).send('Error deleting asset assignment');
    }
});

// --- Employee Project Assignments ---
router.post('/project-assignments', auth, privilege(['project.assignments.create']), async (req, res) => {
    const { staffId, projectId, milestoneName, role, status, dueDate, userId } = req.body;
    try {
        const sql = 'INSERT INTO kemri_employee_project_assignments (staffId, projectId, milestoneName, role, status, dueDate, userId) VALUES (?, ?, ?, ?, ?, ?, ?)';
        const [result] = await pool.query(sql, [staffId, projectId, milestoneName, role, status, formatDate(dueDate), userId]);
        res.status(201).json({ id: result.insertId, message: 'Project assignment added successfully' });
    } catch (err) {
        console.error('Error adding project assignment:', err);
        res.status(500).send('Error adding project assignment');
    }
});

router.put('/project-assignments/:id', auth, privilege(['project.assignments.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, projectId, milestoneName, role, status, dueDate, userId } = req.body;
    try {
        const sql = 'UPDATE kemri_employee_project_assignments SET staffId = ?, projectId = ?, milestoneName = ?, role = ?, status = ?, dueDate = ?, userId = ? WHERE id = ?';
        const [result] = await pool.query(sql, [staffId, projectId, milestoneName, role, status, formatDate(dueDate), userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Project assignment not found.' });
        }
        res.status(200).json({ message: 'Project assignment updated successfully' });
    } catch (err) {
        console.error('Error updating project assignment:', err);
        res.status(500).send('Error updating project assignment');
    }
});

router.delete('/project-assignments/:id', auth, privilege(['project.assignments.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const sql = 'UPDATE kemri_employee_project_assignments SET voided = 1 WHERE id = ?';
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Project assignment not found.' });
        }
        res.status(200).json({ message: 'Project assignment deleted successfully' });
    } catch (err) {
        console.error('Error deleting project assignment:', err);
        res.status(500).send('Error deleting project assignment');
    }
});

// NEW: --- Leave Entitlements ---
router.get('/employees/:id/leave-entitlements', auth, privilege(['leave.entitlement.read']), async (req, res) => {
    const { id } = req.params;
    try {
        const sql = `
            SELECT le.*, lt.name as leaveTypeName 
            FROM kemri_employee_leave_entitlements le
            JOIN kemri_leave_types lt ON le.leaveTypeId = lt.id
            WHERE le.staffId = ? AND le.voided = 0
            ORDER BY le.year DESC, lt.name ASC
        `;
        const [entitlements] = await pool.query(sql, [id]);
        res.json(entitlements);
    } catch (err) {
        console.error('Error fetching leave entitlements:', err);
        res.status(500).send('Error fetching leave entitlements');
    }
});

router.post('/leave-entitlements', auth, privilege(['leave.entitlement.create']), async (req, res) => {
    const { staffId, leaveTypeId, year, allocatedDays, userId } = req.body;
    try {
        const sql = 'INSERT INTO kemri_employee_leave_entitlements (staffId, leaveTypeId, year, allocatedDays, userId) VALUES (?, ?, ?, ?, ?)';
        const [result] = await pool.query(sql, [staffId, leaveTypeId, year, allocatedDays, userId]);
        res.status(201).json({ id: result.insertId, message: 'Leave entitlement added successfully' });
    } catch (err) {
        console.error('Error adding leave entitlement:', err);
        res.status(500).send('Error adding leave entitlement');
    }
});

router.put('/leave-entitlements/:id', auth, privilege(['leave.entitlement.update']), async (req, res) => {
    const { id } = req.params;
    const { staffId, leaveTypeId, year, allocatedDays, userId } = req.body;
    try {
        const sql = 'UPDATE kemri_employee_leave_entitlements SET staffId = ?, leaveTypeId = ?, year = ?, allocatedDays = ?, userId = ? WHERE id = ?';
        const [result] = await pool.query(sql, [staffId, leaveTypeId, year, allocatedDays, userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave entitlement not found.' });
        }
        res.status(200).json({ message: 'Leave entitlement updated successfully' });
    } catch (err) {
        console.error('Error updating leave entitlement:', err);
        res.status(500).send('Error updating leave entitlement');
    }
});

router.delete('/leave-entitlements/:id', auth, privilege(['leave.entitlement.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const sql = 'UPDATE kemri_employee_leave_entitlements SET voided = 1 WHERE id = ?';
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Leave entitlement not found.' });
        }
        res.status(200).json({ message: 'Leave entitlement deleted successfully' });
    } catch (err) {
        console.error('Error deleting leave entitlement:', err);
        res.status(500).send('Error deleting leave entitlement');
    }
});

// NEW: Route to fetch calculated leave balances for an employee
router.get('/employees/:id/leave-balance', auth, async (req, res) => {
    const { id } = req.params;
    const year = req.query.year || new Date().getFullYear(); // Default to current year

    try {
        const sql = `
            SELECT 
                lt.id AS leaveTypeId,
                lt.name AS leaveTypeName,
                COALESCE(le.allocatedDays, 0) AS allocated,
                COALESCE(SUM(la.numberOfDays), 0) AS taken,
                (COALESCE(le.allocatedDays, 0) - COALESCE(SUM(la.numberOfDays), 0)) AS balance
            FROM 
                kemri_leave_types lt
            LEFT JOIN 
                kemri_employee_leave_entitlements le ON lt.id = le.leaveTypeId 
                AND le.staffId = ? 
                AND le.year = ?
            LEFT JOIN 
                kemri_leave_applications la ON lt.id = la.leaveTypeId 
                AND la.staffId = ? 
                AND YEAR(la.startDate) = ? 
                AND la.status IN ('Approved', 'Completed')
            WHERE 
                lt.voided = 0
            GROUP BY 
                lt.id, lt.name, le.allocatedDays;
        `;
        const [balances] = await pool.query(sql, [id, year, id, year]);
        res.json(balances);
    } catch (err) {
        console.error('Error fetching leave balance:', err);
        res.status(500).send('Error fetching leave balance');
    }
});

// In humanResourceRoutes.js

// NEW: Route to calculate working days excluding weekends and public holidays
router.get('/calculate-working-days', auth, async (req, res) => {
    const { startDate, endDate } = req.query;

    if (!startDate || !endDate) {
        return res.status(400).send('startDate and endDate are required.');
    }

    try {
        const [holidays] = await pool.query(
            'SELECT holidayDate FROM kemri_public_holidays WHERE holidayDate BETWEEN ? AND ?',
            [startDate, endDate]
        );
        const holidaySet = new Set(holidays.map(h => new Date(h.holidayDate).toISOString().slice(0, 10)));

        let workingDays = 0;
        let currentDate = new Date(startDate);
        const finalDate = new Date(endDate);

        while (currentDate <= finalDate) {
            const dayOfWeek = currentDate.getDay(); // 0 = Sunday, 6 = Saturday
            const dateString = currentDate.toISOString().slice(0, 10);

            if (dayOfWeek !== 0 && dayOfWeek !== 6 && !holidaySet.has(dateString)) {
                workingDays++;
            }
            currentDate.setDate(currentDate.getDate() + 1);
        }
        res.json({ workingDays });
    } catch (err) {
        console.error('Error calculating working days:', err);
        res.status(500).send('Error calculating working days');
    }
});

// --- Public Holidays Management ---
router.get('/public-holidays', auth, privilege(['holiday.read']), async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_public_holidays WHERE voided = 0 ORDER BY holidayDate DESC');
        res.json(rows);
    } catch (err) {
        console.error('Error fetching public holidays:', err);
        res.status(500).send('Error fetching public holidays');
    }
});

router.post('/public-holidays', auth, privilege(['holiday.create']), async (req, res) => {
    const { holidayName, holidayDate, userId } = req.body;
    try {
        const sql = 'INSERT INTO kemri_public_holidays (holidayName, holidayDate, userId) VALUES (?, ?, ?)';
        const [result] = await pool.query(sql, [holidayName, formatDate(holidayDate), userId]);
        res.status(201).json({ id: result.insertId, message: 'Public holiday added successfully' });
    } catch (err) {
        console.error('Error adding public holiday:', err);
        res.status(500).send('Error adding public holiday');
    }
});

router.put('/public-holidays/:id', auth, privilege(['holiday.update']), async (req, res) => {
    const { id } = req.params;
    const { holidayName, holidayDate, userId } = req.body;
    try {
        const sql = 'UPDATE kemri_public_holidays SET holidayName = ?, holidayDate = ?, userId = ? WHERE id = ?';
        const [result] = await pool.query(sql, [holidayName, formatDate(holidayDate), userId, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Public holiday not found.' });
        }
        res.status(200).json({ message: 'Public holiday updated successfully' });
    } catch (err) {
        console.error('Error updating public holiday:', err);
        res.status(500).send('Error updating public holiday');
    }
});

router.delete('/public-holidays/:id', auth, privilege(['holiday.delete']), async (req, res) => {
    const { id } = req.params;
    try {
        const sql = 'UPDATE kemri_public_holidays SET voided = 1 WHERE id = ?';
        const [result] = await pool.query(sql, [id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Public holiday not found.' });
        }
        res.status(200).json({ message: 'Public holiday deleted successfully' });
    } catch (err) {
        console.error('Error deleting public holiday:', err);
        res.status(500).send('Error deleting public holiday');
    }
});

module.exports = router;