// backend/routes/auth.js
const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../config/db'); // Your database connection pool

require('dotenv').config(); // Load environment variables

const JWT_SECRET = process.env.JWT_SECRET || 'your_fallback_secret_for_dev_only_change_this_asap';

router.post('/test-reach', (req, res) => {
    res.status(200).json({ message: 'Auth test route reached!' });
});

/**
 * @file Authentication routes for user login and registration.
 * @description Handles user authentication, including password comparison and JWT token generation.
 */

/**
 * Helper function to fetch privileges for a given role ID.
 * @param {number} roleId - The ID of the role.
 * @returns {Promise<string[]>} An array of privilege names.
 */
async function getPrivilegesByRole(roleId) {
    try {
        const [rows] = await pool.query(
            `SELECT kp.privilegeName
             FROM kemri_roles kr
             JOIN kemri_role_privileges krp ON kr.roleId = krp.roleId
             JOIN kemri_privileges kp ON krp.privilegeId = kp.privilegeId
             WHERE kr.roleId = ?`,
            [roleId]
        );
        return rows.map(row => row.privilegeName);
    } catch (error) {
 
        return [];
    }
}

// @route   POST /register
// @desc    Register a new user
// @access  Public
router.post('/register', async (req, res) => {
    const { username, email, password, firstName, lastName, roleName } = req.body;

    if (!username || !email || !password || !firstName || !lastName) {
        return res.status(400).json({ error: 'Please enter all required fields: username, email, password, first name, last name.' });
    }

    let connection;
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
        
        const [roleRows] = await pool.query('SELECT roleId FROM kemri_roles WHERE roleName = ?', [roleName || 'user']);
        const roleId = roleRows.length > 0 ? roleRows[0].roleId : null;

        if (!roleId) {
            return res.status(400).json({ error: 'Invalid role provided.' });
        }
        
        connection = await pool.getConnection();
        await connection.beginTransaction();

        const [userResult] = await connection.execute(
            'INSERT INTO kemri_users (username, email, passwordHash, firstName, lastName, roleId) VALUES (?, ?, ?, ?, ?, ?)',
            [username, email, passwordHash, firstName, lastName, roleId]
        );
        const userId = userResult.insertId;
        
        const userPrivileges = await getPrivilegesByRole(roleId);

        const payload = {
            user: {
                id: userId,
                username: username,
                email: email,
                roleId: roleId,
                roleName: roleName || 'user',
                privileges: userPrivileges
            }
        };

        jwt.sign(
            payload,
            JWT_SECRET,
            { expiresIn: '24h' }, // Changed to 24 hours for a better user experience
            (err, token) => {
                if (err) {
                    connection.rollback();
                    return res.status(500).json({ error: 'Server error during token generation.' });
                }
                res.status(201).json({ message: 'User registered successfully!', token });
            }
        );

        await connection.commit();

    } catch (err) {
        if (connection) {
            await connection.rollback();
        }
        
        if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: 'User with that username or email already exists.' });
        }
        res.status(500).json({ error: 'Server error during registration.' });
    } finally {
        if (connection) {
            connection.release();
        }
    }
});

// @route   POST /login
// @desc    Authenticate user & get token
// @access  Public
router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    try {
        const query = `
            SELECT 
                u.*, 
                r.roleName AS role,
                cu.contractorId
            FROM kemri_users u
            LEFT JOIN kemri_roles r ON u.roleId = r.roleId
            LEFT JOIN kemri_contractor_users cu ON u.userId = cu.userId
             WHERE (u.username = ? OR u.email = ?) AND u.voided = 0
        `;
        const [users] = await pool.execute(query, [username, username]);

        if (users.length === 0) {
            return res.status(400).json({ error: 'Invalid credentials.' });
        }

        const user = users[0];
        if (!user.passwordHash) {
            
            return res.status(500).json({ error: 'Server configuration error: User password not set.' });
        }

        const isMatch = await bcrypt.compare(password, user.passwordHash);

        if (!isMatch) {
            return res.status(400).json({ error: 'Invalid credentials.' });
        }
        
        const userPrivileges = await getPrivilegesByRole(user.roleId);

        const payload = {
            user: {
                id: user.userId,
                actualUserId: user.userId,
                username: user.username,
                email: user.email,
                roleId: user.roleId,
                roleName: user.role,
                privileges: userPrivileges,
                ...(user.contractorId && { contractorId: user.contractorId })
            }
        };

        jwt.sign(
            payload,
            JWT_SECRET,
            { expiresIn: '24h' }, // Changed to 24 hours for a better user experience
            (err, token) => {
                if (err) {
                    
                    return res.status(500).json({ error: 'Server error during token generation.' });
                }
                res.json({ token, message: 'Logged in successfully!' });
            }
        );

    } catch (err) {
      
        res.status(500).json({ error: 'Server error during login.' });
    }
});

module.exports = router;