// backend/middleware/authenticate.js
const jwt = require('jsonwebtoken');
require('dotenv').config(); // Load environment variables

const JWT_SECRET = process.env.JWT_SECRET || 'your_fallback_secret_for_dev_only_change_this_asap'; // Use the same secret as in auth.js

module.exports = function (req, res, next) {
    // Get token from header
    // Check for "Authorization" header, which is typically "Bearer TOKEN"
    const authHeader = req.header('Authorization');

    // Check if no Authorization header
    if (!authHeader) {
        return res.status(401).json({ msg: 'No token, authorization denied (Missing Authorization header)' });
    }

    // Extract the token from "Bearer TOKEN" format
    const token = authHeader.split(' ')[1];

    // Check if token is actually present after splitting
    if (!token) {
        return res.status(401).json({ msg: 'Invalid token format, authorization denied (Bearer token missing)' });
    }

    // Verify token
    try {
        const decoded = jwt.verify(token, JWT_SECRET); // Verify the token using your secret

        // Attach user information from the token payload to the request object
        // This makes user info (like user ID, username, email, role, privileges) available in your route handlers
        req.user = decoded.user;
        next(); // Proceed to the next middleware/route handler
    } catch (err) {
        // If token is invalid (e.g., expired, tampered)
        console.error('Token verification failed:', err.message);
        res.status(401).json({ msg: 'Token is not valid' });
    }
};
