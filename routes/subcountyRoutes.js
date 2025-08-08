const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool

// --- Routes for kemri_subcounties (direct access, if needed for full list) ---
/**
 * @route GET /api/subcounties/
 * @description Get all subcounties from the kemri_subcounties table.
 * Note: Subcounties can also be fetched by county via /api/counties/:countyId/subcounties
 */
router.get('/', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT subcountyId, name, countyId FROM kemri_subcounties');
        res.status(200).json(rows);
    } catch (error) {
        console.error('Error fetching all subcounties:', error);
        res.status(500).json({ message: 'Error fetching all subcounties', error: error.message });
    }
});


// --- Routes for kemri_wards (nested under subcounty) ---

/**
 * @route GET /api/subcounties/:subcountyId/wards
 * @description Get all wards belonging to a specific sub-county from the kemri_wards table.
 */
router.get('/:subcountyId/wards', async (req, res) => {
    const { subcountyId } = req.params;
    try {
        const [rows] = await pool.query('SELECT wardId, name FROM kemri_wards WHERE subcountyId = ?', [subcountyId]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(`Error fetching wards for sub-county ${subcountyId}:`, error);
        res.status(500).json({ message: `Error fetching wards for sub-county ${subcountyId}`, error: error.message });
    }
});

module.exports = router;
