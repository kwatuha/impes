const express = require('express');
const router = express.Router();
const pool = require('../config/db');
const bcrypt = require('bcryptjs');

// --- CRUD Operations for kemri_users ---

/**
 * @route GET /api/users/users
 * @description Get all users from the kemri_users table.
 */
router.get('/users', async (req, res) => {
    try {
        const [rows] = await pool.query(`
            SELECT 
                u.userId, u.username, u.email, u.firstName, u.lastName, u.createdAt, u.updatedAt, u.isActive, u.roleId, r.roleName AS role
            FROM kemri_users u
            LEFT JOIN kemri_roles r ON u.roleId = r.roleId
        `);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ message: 'Error fetching users', error: error.message });
    }
});

/**
 * @route GET /api/users/users/:id
 * @description Get a single user by user_id from the kemri_users table.
 */
router.get('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query(`
            SELECT 
                u.userId, u.username, u.email, u.firstName, u.lastName, u.createdAt, u.updatedAt, u.isActive, u.roleId, r.roleName AS role
            FROM kemri_users u
            LEFT JOIN kemri_roles r ON u.roleId = r.roleId
            WHERE u.userId = ?
        `, [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        console.error('Error fetching user:', error);
        res.status(500).json({ message: 'Error fetching user', error: error.message });
    }
});

/**
 * @route POST /api/users/users
 * @description Create a new user in the kemri_users table.
 */
router.post('/users', async (req, res) => {
    const { username, email, password, firstName, lastName, roleId } = req.body;

    if (!username || !email || !password || !firstName || !lastName || !roleId) {
        return res.status(400).json({ error: 'Please enter all required fields: username, email, password, first name, last name, and role ID.' });
    }

    try {
        const [existingUsers] = await pool.execute(
            'SELECT userId FROM kemri_users WHERE username = ? OR email = ?',
            [username, email]
        );

        if (existingUsers.length > 0) {
            return res.status(400).json({ error: 'User with that username or email already exists.' });
        }

        const salt = await bcrypt.genSalt(10);
        const passwordHash = await bcrypt.hash(password, salt);

        const newUser = {
            username,
            email,
            passwordHash,
            firstName,
            lastName,
            roleId,
            createdAt: new Date(),
            updatedAt: new Date(),
            isActive: true,
        };

        const [result] = await pool.query('INSERT INTO kemri_users SET ?', newUser);
        
        const insertedUserId = result.insertId;
        const [rows] = await pool.query(`
            SELECT 
                u.userId, u.username, u.email, u.firstName, u.lastName, u.roleId, r.roleName AS role, u.createdAt, u.updatedAt, u.isActive
            FROM kemri_users u
            LEFT JOIN kemri_roles r ON u.roleId = r.roleId
            WHERE u.userId = ?
        `, [insertedUserId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating user:', error);
        if (error.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: 'User with that username or email already exists.' });
        }
        res.status(500).json({ message: 'Error creating user', error: error.message });
    }
});

/**
 * @route PUT /api/users/users/:id
 * @description Update an existing user in the kemri_users table.
 */
router.put('/users/:id', async (req, res) => {
    const { id } = req.params;
    const { password, ...otherFieldsToUpdate } = req.body;

    const fieldsToUpdate = { ...otherFieldsToUpdate, updatedAt: new Date() };

    if (password && password.trim() !== '') {
        const salt = await bcrypt.genSalt(10);
        fieldsToUpdate.passwordHash = await bcrypt.hash(password, salt);
    }
    delete fieldsToUpdate.userId;

    try {
        const [result] = await pool.query('UPDATE kemri_users SET ? WHERE userId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query(`
                SELECT 
                    u.userId, u.username, u.email, u.firstName, u.lastName, u.roleId, r.roleName AS role, u.createdAt, u.updatedAt, u.isActive
                FROM kemri_users u
                LEFT JOIN kemri_roles r ON u.roleId = r.roleId
                WHERE u.userId = ?
            `, [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ message: 'Error updating user', error: error.message });
    }
});

/**
 * @route DELETE /api/users/users/:id
 * @description Delete a user from the kemri_users table.
 */
router.delete('/users/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_users WHERE userId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'User not found' });
        }
    } catch (error) {
        console.error('Error deleting user:', error);
        res.status(500).json({ message: 'Error deleting user', error: error.message });
    }
});

// --- CRUD Operations for kemri_roles ---

/**
 * @route GET /api/users/roles
 * @description Get all roles from the kemri_roles table.
 */
router.get('/roles', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_roles');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching roles:', error);
        res.status(500).json({ message: 'Error fetching roles', error: error.message });
    }
});

/**
 * @route GET /api/users/roles/:id
 * @description Get a single role by role_id from the kemri_roles table.
 */
router.get('/roles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_roles WHERE roleId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Role not found' });
        }
    } catch (error) {
        console.error('Error fetching role:', error);
        res.status(500).json({ message: 'Error fetching role', error: error.message });
    }
});

/**
 * @route POST /api/users/roles
 * @description Create a new role in the kemri_roles table.
 */
router.post('/roles', async (req, res) => {
    const newRole = {
        createdAt: new Date(),
        updatedAt: new Date(),
        ...req.body
    };
    delete newRole.roleId;

    try {
        const [result] = await pool.query('INSERT INTO kemri_roles SET ?', newRole);
        const insertedRoleId = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_roles WHERE roleId = ?', [insertedRoleId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating role:', error);
        res.status(500).json({ message: 'Error creating role', error: error.message });
    }
});

/**
 * @route PUT /api/users/roles/:id
 * @description Update an existing role in the kemri_roles table.
 */
router.put('/roles/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body, updatedAt: new Date() };
    delete fieldsToUpdate.roleId;

    try {
        const [result] = await pool.query('UPDATE kemri_roles SET ? WHERE roleId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_roles WHERE roleId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Role not found' });
        }
    } catch (error) {
        console.error('Error updating role:', error);
        res.status(500).json({ message: 'Error updating role', error: error.message });
    }
});

/**
 * @route DELETE /api/users/roles/:id
 * @description Delete a role from the kemri_roles table.
 */
router.delete('/roles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_roles WHERE roleId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Role not found' });
        }
    } catch (error) {
        console.error('Error deleting role:', error);
        res.status(500).json({ message: 'Error deleting role', error: error.message });
    }
});

// --- CRUD Operations for kemri_privileges ---

/**
 * @route GET /api/users/privileges
 * @description Get all privileges from the kemri_privileges table.
 */
router.get('/privileges', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_privileges');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching privileges:', error);
        res.status(500).json({ message: 'Error fetching privileges', error: error.message });
    }
});

/**
 * @route GET /api/users/privileges/:id
 * @description Get a single privilege by privilege_id from the kemri_privileges table.
 */
router.get('/privileges/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_privileges WHERE privilegeId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Privilege not found' });
        }
    } catch (error) {
        console.error('Error fetching privilege:', error);
        res.status(500).json({ message: 'Error fetching privilege', error: error.message });
    }
});

/**
 * @route POST /api/users/privileges
 * @description Create a new privilege in the kemri_privileges table.
 */
router.post('/privileges', async (req, res) => {
    const newPrivilege = {
        createdAt: new Date(),
        updatedAt: new Date(),
        ...req.body
    };
    delete newPrivilege.privilegeId;

    try {
        const [result] = await pool.query('INSERT INTO kemri_privileges SET ?', newPrivilege);
        const insertedPrivilegeId = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_privileges WHERE privilegeId = ?', [insertedPrivilegeId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating privilege:', error);
        res.status(500).json({ message: 'Error creating privilege', error: error.message });
    }
});

/**
 * @route PUT /api/users/privileges/:id
 * @description Update an existing privilege in the kemri_privileges table.
 */
router.put('/privileges/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body, updatedAt: new Date() };
    delete fieldsToUpdate.privilegeId;

    try {
        const [result] = await pool.query('UPDATE kemri_privileges SET ? WHERE privilegeId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_privileges WHERE privilegeId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Privilege not found' });
        }
    } catch (error) {
        console.error('Error updating privilege:', error);
        res.status(500).json({ message: 'Error updating privilege', error: error.message });
    }
});

/**
 * @route DELETE /api/users/privileges/:id
 * @description Delete a privilege from the kemri_privileges table.
 */
router.delete('/privileges/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_privileges WHERE privilegeId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Privilege not found' });
        }
    } catch (error) {
        console.error('Error deleting privilege:', error);
        res.status(500).json({ message: 'Error deleting privilege', error: error.message });
    }
});

// --- CRUD Operations for kemri_role_privileges ---

/**
 * @route GET /api/users/role_privileges
 * @description Get all role privileges from the kemri_role_privileges table.
 * @query roleId - Optional: Filter by roleId
 * @query privilegeId - Optional: Filter by privilegeId
 */
router.get('/role_privileges', async (req, res) => {
    const { roleId, privilegeId } = req.query;
    let query = 'SELECT * FROM kemri_role_privileges';
    const queryParams = [];
    const conditions = [];

    if (roleId) {
        conditions.push('roleId = ?');
        queryParams.push(roleId);
    }
    if (privilegeId) {
        conditions.push('privilegeId = ?');
        queryParams.push(privilegeId);
    }

    if (conditions.length > 0) {
        query += ` WHERE ${conditions.join(' AND ')}`;
    }

    try {
        const [rows] = await pool.query(query, queryParams);
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching role privileges:', error);
        res.status(500).json({ message: 'Error fetching role privileges', error: error.message });
    }
});

/**
 * @route GET /api/users/role_privileges/:roleId/:privilegeId
 * @description Get a single role privilege by role_id and privilege_id from the kemri_role_privileges table.
 */
router.get('/role_privileges/:roleId/:privilegeId', async (req, res) => {
    const { roleId, privilegeId } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_role_privileges WHERE roleId = ? AND privilegeId = ?', [roleId, privilegeId]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Role privilege not found' });
        }
    }
    catch (error) {
        console.error('Error fetching role privilege:', error);
        res.status(500).json({ message: 'Error fetching role privilege', error: error.message });
    }
});

/**
 * @route POST /api/users/role_privileges
 * @description Create a new role privilege assignment in the kemri_role_privileges table.
 * @body {number} roleId - The ID of the role.
 * @body {number} privilegeId - The ID of the privilege.
 */
router.post('/role_privileges', async (req, res) => {
    const { roleId, privilegeId } = req.body;
    if (!roleId || !privilegeId) {
        return res.status(400).json({ message: 'roleId and privilegeId are required.' });
    }
    const newRolePrivilege = {
        roleId: roleId,
        privilegeId: privilegeId,
        createdAt: new Date(),
    };
    try {
        // Use INSERT IGNORE to handle potential duplicate composite primary key gracefully
        await pool.query('INSERT IGNORE INTO kemri_role_privileges SET ?', newRolePrivilege);
        res.status(201).json(newRolePrivilege);
    } catch (error) {
        console.error('Error creating role privilege:', error);
        res.status(500).json({ message: 'Error creating role privilege', error: error.message });
    }
});

/**
 * @route DELETE /api/users/role_privileges/:roleId/:privilegeId
 * @description Delete a role privilege assignment from the kemri_role_privileges table.
 */
router.delete('/role_privileges/:roleId/:privilegeId', async (req, res) => {
    const { roleId, privilegeId } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_role_privileges WHERE roleId = ? AND privilegeId = ?', [roleId, privilegeId]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Role privilege not found' });
        }
    } catch (error) {
        console.error('Error deleting role privilege:', error);
        res.status(500).json({ message: 'Error deleting role privilege', error: error.message });
    }
});

// --- CRUD Operations for kemri_staff ---

/**
 * @route GET /api/users/staff
 * @description Get all staff from the kemri_staff table.
 */
router.get('/staff', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_staff');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching staff:', error);
        res.status(500).json({ message: 'Error fetching staff', error: error.message });
    }
});

/**
 * @route GET /api/users/staff/:id
 * @description Get a single staff by staff_id from the kemri_staff table.
 */
router.get('/staff/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_staff WHERE staffId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Staff member not found' });
        }
    } catch (error) {
        console.error('Error fetching staff member:', error);
        res.status(500).json({ message: 'Error fetching staff member', error: error.message });
    }
});

/**
 * @route POST /api/users/staff
 * @description Create a new staff member in the kemri_staff table.
 */
router.post('/staff', async (req, res) => {
    const newStaff = {
        createdAt: new Date(),
        updatedAt: new Date(),
        ...req.body
    };
    delete newStaff.staffId;

    try {
        const [result] = await pool.query('INSERT INTO kemri_staff SET ?', newStaff);
        const insertedStaffId = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_staff WHERE staffId = ?', [insertedStaffId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating staff member:', error);
        res.status(500).json({ message: 'Error creating staff member', error: error.message });
    }
});

/**
 * @route PUT /api/users/staff/:id
 * @description Update an existing staff member in the kemri_staff table.
 */
router.put('/staff/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body, updatedAt: new Date() };
    delete fieldsToUpdate.staffId;

    try {
        const [result] = await pool.query('UPDATE kemri_staff SET ? WHERE staffId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_staff WHERE staffId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Staff member not found' });
        }
    } catch (error) {
        console.error('Error updating staff member:', error);
        res.status(500).json({ message: 'Error updating staff member', error: error.message });
    }
});

/**
 * @route DELETE /api/users/staff/:id
 * @description Delete a staff member from the kemri_staff table.
 */
router.delete('/staff/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_staff WHERE staffId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Staff member not found' });
        }
    } catch (error) {
        console.error('Error deleting staff member:', error);
        res.status(500).json({ message: 'Error deleting staff member', error: error.message });
    }
});

// --- CRUD Operations for kemri_project_roles ---

/**
 * @route GET /api/users/project_roles
 * @description Get all project roles from the kemri_project_roles table.
 */
router.get('/project_roles', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_roles');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching project roles:', error);
        res.status(500).json({ message: 'Error fetching project roles', error: error.message });
    }
});

/**
 * @route GET /api/users/project_roles/:id
 * @description Get a single project role by role_id from the kemri_project_roles table.
 */
router.get('/project_roles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_roles WHERE roleId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project role not found' });
        }
    } catch (error) {
        console.error('Error fetching project role:', error);
        res.status(500).json({ message: 'Error fetching project role', error: error.message });
    }
});

/**
 * @route POST /api/users/project_roles
 * @description Create a new project role in the kemri_project_roles table.
 */
router.post('/project_roles', async (req, res) => {
    const newProjectRole = {
        ...req.body
    };
    delete newProjectRole.roleId;

    try {
        const [result] = await pool.query('INSERT INTO kemri_project_roles SET ?', newProjectRole);
        const insertedRoleId = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_project_roles WHERE roleId = ?', [insertedRoleId]);
        res.status(201).json(rows[0]);
    }
    catch (error) {
        console.error('Error creating project role:', error);
        res.status(500).json({ message: 'Error creating project role', error: error.message });
    }
});

/**
 * @route PUT /api/users/project_roles/:id
 * @description Update an existing project role in the kemri_project_roles table.
 */
router.put('/project_roles/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body };
    delete fieldsToUpdate.roleId;

    try {
        const [result] = await pool.query('UPDATE kemri_project_roles SET ? WHERE roleId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_project_roles WHERE roleId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project role not found' });
        }
    } catch (error) {
        console.error('Error updating project role:', error);
        res.status(500).json({ message: 'Error updating project role', error: error.message });
    }
});

/**
 * @route DELETE /api/users/project_roles/:id
 * @description Delete a project role from the kemri_project_roles table.
 */
router.delete('/project_roles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_project_roles WHERE roleId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Project role not found' });
        }
    } catch (error) {
        console.error('Error deleting project role:', error);
        res.status(500).json({ message: 'Error deleting project role', error: error.message });
    }
});

// --- CRUD Operations for kemri_project_staff_assignments ---

/**
 * @route GET /api/users/project_staff_assignments
 * @description Get all project staff assignments from the kemri_project_staff_assignments table.
 */
router.get('/project_staff_assignments', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_staff_assignments');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching project staff assignments:', error);
        res.status(500).json({ message: 'Error fetching project staff assignments', error: error.message });
    }
});

/**
 * @route GET /api/users/project_staff_assignments/:id
 * @description Get a single project staff assignment by assignment_id from the kemri_project_staff_assignments table.
 */
router.get('/project_staff_assignments/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_staff_assignments WHERE assignmentId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project staff assignment not found' });
        }
    } catch (error) {
        console.error('Error fetching project staff assignment:', error);
        res.status(500).json({ message: 'Error fetching project staff assignment', error: error.message });
    }
});

/**
 * @route POST /api/users/project_staff_assignments
 * @description Create a new project staff assignment in the kemri_project_staff_assignments table.
 */
router.post('/project_staff_assignments', async (req, res) => {
    const newAssignment = {
        createdAt: new Date(),
        ...req.body
    };
    delete newAssignment.assignmentId;

    try {
        const [result] = await pool.query('INSERT INTO kemri_project_staff_assignments SET ?', newAssignment);
        const insertedAssignmentId = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_project_staff_assignments WHERE assignmentId = ?', [insertedAssignmentId]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating project staff assignment:', error);
        res.status(500).json({ message: 'Error creating project staff assignment', error: error.message });
    }
});

/**
 * @route PUT /api/users/project_staff_assignments/:id
 * @description Update an existing project staff assignment in the kemri_project_staff_assignments table.
 */
router.put('/project_staff_assignments/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body };
    delete fieldsToUpdate.assignmentId;

    try {
        const [result] = await pool.query('UPDATE kemri_project_staff_assignments SET ? WHERE assignmentId = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_project_staff_assignments WHERE assignmentId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project staff assignment not found' });
        }
    } catch (error) {
        console.error('Error updating project staff assignment:', error);
        res.status(500).json({ message: 'Error updating project staff assignment', error: error.message });
    }
});

/**
 * @route DELETE /api/users/project_staff_assignments/:id
 * @description Delete a project staff assignment from the kemri_project_staff_assignments table.
 */
router.delete('/project_staff_assignments/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_project_staff_assignments WHERE assignmentId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Project staff assignment not found' });
        }
    } catch (error) {
        console.error('Error deleting project staff assignment:', error);
        res.status(500).json({ message: 'Error deleting project staff assignment', error: error.message });
    }
});

// --- CRUD Operations for kemri_websitepublicprofiles ---

/**
 * @route GET /api/users/website_public_profiles
 * @description Get all website public profiles from the kemri_websitepublicprofiles table.
 */
router.get('/website_public_profiles', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_websitepublicprofiles');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching website public profiles:', error);
        res.status(500).json({ message: 'Error fetching website public profiles', error: error.message });
    }
});

/**
 * @route GET /api/users/website_public_profiles/:id
 * @description Get a single website public profile by ProfileID from the kemri_websitepublicprofiles table.
 */
router.get('/website_public_profiles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_websitepublicprofiles WHERE ProfileID = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Website public profile not found' });
        }
    } catch (error) {
        console.error('Error fetching website public profile:', error);
        res.status(500).json({ message: 'Error fetching website public profile', error: error.message });
    }
});

/**
 * @route POST /api/users/website_public_profiles
 * @description Create a new website public profile in the kemri_websitepublicprofiles table.
 */
router.post('/website_public_profiles', async (req, res) => {
    const newProfile = {
        voided: req.body.voided !== undefined ? req.body.voided : false,
        voidedBy: req.body.voidedBy !== undefined ? req.body.voidedBy : null,
        ...req.body
    };
    delete newProfile.ProfileID;

    try {
        const [result] = await pool.query('INSERT INTO kemri_websitepublicprofiles SET ?', newProfile);
        const insertedProfileID = result.insertId;
        const [rows] = await pool.query('SELECT * FROM kemri_websitepublicprofiles WHERE ProfileID = ?', [insertedProfileID]);
        res.status(201).json(rows[0]);
    } catch (error) {
        console.error('Error creating website public profile:', error);
        res.status(500).json({ message: 'Error creating website public profile', error: error.message });
    }
});

/**
 * @route PUT /api/users/website_public_profiles/:id
 * @description Update an existing website public profile in the kemri_websitepublicprofiles table.
 */
router.put('/website_public_profiles/:id', async (req, res) => {
    const { id } = req.params;
    const fieldsToUpdate = { ...req.body };
    delete fieldsToUpdate.ProfileID;

    try {
        const [result] = await pool.query('UPDATE kemri_websitepublicprofiles SET ? WHERE ProfileID = ?', [fieldsToUpdate, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_websitepublicprofiles WHERE ProfileID = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Website public profile not found' });
        }
    } catch (error) {
        console.error('Error updating website public profile:', error);
        res.status(500).json({ message: 'Error updating website public profile', error: error.message });
    }
});

/**
 * @route DELETE /api/users/website_public_profiles/:id
 * @description Delete a website public profile from the kemri_websitepublicprofiles table.
 */
router.delete('/website_public_profiles/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_websitepublicprofiles WHERE ProfileID = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Website public profile not found' });
        }
    } catch (error) {
        console.error('Error deleting website public profile:', error);
        res.status(500).json({ message: 'Error deleting website public profile', error: error.message });
    }
});

module.exports = router;