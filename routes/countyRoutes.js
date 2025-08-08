const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool

// --- Routes for kemri_counties ---

/**
 * @route GET /api/counties/
 * @description Get all counties from the kemri_counties table.
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT countyId, name FROM kemri_counties');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching counties:', error);
        res.status(500).json({ message: 'Error fetching counties', error: error.message });
    }
});

/**
 * @route GET /api/counties/:countyId/subcounties
 * @description Get all sub-counties belonging to a specific county from the kemri_subcounties table.
 */
router.get('/:countyId/subcounties', async (req, res) => {
    const { countyId } = req.params;
    try {
        const [rows] = await pool.query('SELECT subcountyId, name FROM kemri_subcounties WHERE countyId = ?', [countyId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching sub-counties for county ${countyId}:`, error);
        res.status(500).json({ message: `Error fetching sub-counties for county ${countyId}`, error: error.message });
    }
});

module.exports = router;
