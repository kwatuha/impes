// src/routes/metadataRoutes.js

const express = require('express');
const router = express.Router();

// Import sub-routers from the new /metadata folder
const departmentRouter = require('./metadata/departmentRoutes');
const financialYearRouter = require('./metadata/financialYearRoutes');
const programRouter = require('./metadata/programRoutes');
const subProgramRouter = require('./metadata/subProgramRoutes');
const countyRouter = require('./metadata/countyRoutes');
const subcountyRouter = require('./metadata/subcountyRoutes');
const wardRouter = require('./metadata/wardRoutes');
const projectCategoryRouter = require('./metadata/projectCategoryRoutes');
const sectionRouter = require('./metadata/sectionRoutes'); // <-- CORRECTED: Added this import

// Mount sub-routers under their respective paths
router.use('/departments', departmentRouter);
router.use('/financialyears', financialYearRouter);
router.use('/programs', programRouter);
router.use('/subprograms', subProgramRouter);
router.use('/counties', countyRouter);
router.use('/subcounties', subcountyRouter);
router.use('/wards', wardRouter);
router.use('/projectcategories', projectCategoryRouter);
router.use('/sections', sectionRouter); // <-- CORRECTED: Mounted the sectionRouter

module.exports = router;