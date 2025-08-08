const express = require('express');
const router = express.Router();
const path = require('path'); // Import path module for file paths
const fs = require('fs'); // Import fs module for file system operations

// --- Route for Downloading Strategic Plan Template ---
/**
 * @route GET /api/strategy/download-template
 * @description Serves the Excel template file for strategic plan data import.
 * This route is PUBLIC (no authentication required).
 */
router.get('/download-template', (req, res) => {
    // Adjust this path to correctly point to your template file
    // Assuming 'templates' folder is at the same level as 'routes' folder
    const templateFilePath = path.join(__dirname, '..', 'templates', 'strategic_plan_template.xlsx');
    console.log('Attempting to send template from:', templateFilePath);

    // Check if the file exists before attempting to send
    fs.access(templateFilePath, fs.constants.F_OK, (err) => {
        if (err) {
            console.error('Template file not found at:', templateFilePath);
            return res.status(404).json({ message: 'Template file not found.' });
        }

        res.download(templateFilePath, 'strategic_plan_template.xlsx', (downloadErr) => {
            if (downloadErr) {
                console.error('Error sending template file:', downloadErr);
                res.status(500).json({ message: 'Failed to download template file.', error: downloadErr.message });
            }
        });
    });
});

module.exports = router;
