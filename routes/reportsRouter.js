const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Adjust the path as needed

/**
 * @route GET /api/reports/department-summary
 * @description Get aggregated project data grouped by department
 * @access Private (assuming authentication middleware is applied)
 * @returns {Array} List of departments with aggregated project metrics
 */
router.get('/department-summary', async (req, res) => {
    try {
        const { finYearId, status } = req.query;

        let whereConditions = ['p.voided = 0'];
        const queryParams = [];

        if (finYearId) {
            whereConditions.push('p.finYearId = ?');
            queryParams.push(finYearId);
        }

        if (status) {
            whereConditions.push('p.status = ?');
            queryParams.push(status);
        }

        const sqlQuery = `
            SELECT
                d.name AS departmentName,
                COUNT(p.id) AS projectCount,
                SUM(p.costOfProject) AS totalBudget,
                SUM(p.paidOut) AS totalPaid,
                SUM(p.paidOut) / SUM(p.costOfProject) AS absorptionRate,
                SUM(pr.amount) AS totalContractSum
            FROM
                kemri_projects p
            LEFT JOIN
                kemri_departments d ON p.departmentId = d.departmentId
            LEFT JOIN
                kemri_project_payment_requests pr ON p.id = pr.projectId
            ${whereConditions.length > 0 ? `WHERE ${whereConditions.join(' AND ')}` : ''}
            GROUP BY
                d.name
            ORDER BY
                d.name;
        `;

        const [rows] = await pool.query(sqlQuery, queryParams);
        res.status(200).json(rows);

    } catch (error) {
        console.error('Error fetching department summary report:', error);
        res.status(500).json({
            message: 'Error fetching department summary report',
            error: error.message
        });
    }
});


module.exports = router;