const express = require('express');
const bodyParser = require('body-parser');
const authenticate = require('./middleware/authenticate');
const cors = require('cors');
const path = require('path'); // ADDED: Import the path module

// Import all your route groups
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const projectRoutes = require('./routes/projectRoutes');
const orgRoutes = require('./routes/orgRoutes');
const strategyRoutes = require('./routes/strategic.routes');
const participantRoutes = require('./routes/participantRoutes');
const generalRoutes = require('./routes/generalRoutes');
const dashboardRoutes = require('./routes/dashboardRoutes');
const metaDataRoutes = require('./routes/metaDataRoutes');
const taskRoutes = require('./routes/taskRoutes');
const milestoneRoutes = require('./routes/milestoneRoutes');
const taskAssigneesRoutes = require('./routes/taskAssigneesRoutes');
const taskDependenciesRoutes = require('./routes/taskDependenciesRoutes');
const projectConceptNoteRoutes = require('./routes/projectConceptNoteRoutes');
const projectNeedsAssessmentRoutes = require('./routes/projectNeedsAssessmentRoutes');
const projectFinancialsRoutes = require('./routes/projectFinancialsRoutes');
const projectFyBreakdownRoutes = require('./routes/projectFyBreakdownRoutes');
const projectSustainabilityRoutes = require('./routes/projectSustainabilityRoutes');
const projectImplementationPlanRoutes = require('./routes/projectImplementationPlanRoutes');
const projectMAndERoutes = require('./routes/projectMAndERoutes');
const projectRisksRoutes = require('./routes/projectRisksRoutes');
const projectStakeholdersRoutes = require('./routes/projectStakeholdersRoutes');
const projectReadinessRoutes = require('./routes/projectReadinessRoutes');
const projectHazardAssessmentRoutes = require('./routes/projectHazardAssessmentRoutes');
const projectClimateRiskRoutes = require('./routes/projectClimateRiskRoutes');
const projectEsohsgScreeningRoutes = require('./routes/projectEsohsgScreeningRoutes');
const projectPdfRoutes = require('./routes/projectPdfRoutes');
const { projectRouter: projectPhotoRouter, photoRouter } = require('./routes/projectPhotoRoutes');
const contractorRoutes = require('./routes/contractorRoutes');
const paymentRequestRoutes = require('./routes/paymentRequestRoutes');
const contractorPhotoRoutes = require('./routes/contractorPhotoRoutes');
const hrRoutes = require('./routes/humanResourceRoutes');

const app = express();
const port = 3000;

const corsOptions = {
  origin: '*',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204
};
app.use(cors(corsOptions));

// 🐛 FIX: Removed the global body-parser.json() middleware.
// app.use(bodyParser.json());

// --- Serve static files from the 'uploads' directory ---
// UPDATED: Corrected the path to point to the 'uploads' folder outside the app directory
app.use('/uploads', express.static(path.join(__dirname, '..', 'uploads')));

// Root route
app.get('/', (req, res) => {
    res.send('Welcome to the KEMRI CRUD API!');
});

// --- Public Routes (No Authentication Required) ---
// 🐛 FIX: Apply express.json() specifically to the routes that need it.
app.use('/api/auth', express.json(), authRoutes);

// --- Protected Routes (Authentication Required) ---
app.use('/api', authenticate);

// Use the grouped routes (these will now be protected)
app.use('/api/users', express.json(), userRoutes);
app.use('/api/projects', express.json(), projectRoutes);
app.use('/api/organization', express.json(), orgRoutes);
app.use('/api/strategy', express.json(), strategyRoutes);
app.use('/api/participants', express.json(), participantRoutes);
app.use('/api/general', express.json(), generalRoutes);
app.use('/api/dashboard', express.json(), dashboardRoutes);
app.use('/api/metadata', express.json(), metaDataRoutes);

app.use('/api/tasks', express.json(), taskRoutes);
app.use('/api/milestones', express.json(), milestoneRoutes);
app.use('/api/task_assignees', express.json(), taskAssigneesRoutes);
app.use('/api/task_dependencies', express.json(), taskDependenciesRoutes);

// NEW: Mount the new modular project-related routes
app.use('/api/projects', express.json(), projectConceptNoteRoutes);
app.use('/api/projects', express.json(), projectNeedsAssessmentRoutes);
app.use('/api/projects', express.json(), projectFinancialsRoutes);
app.use('/api/projects', express.json(), projectFyBreakdownRoutes);
app.use('/api/projects', express.json(), projectSustainabilityRoutes);
app.use('/api/projects', express.json(), projectImplementationPlanRoutes);
app.use('/api/projects', express.json(), projectMAndERoutes);
app.use('/api/projects', express.json(), projectRisksRoutes);
app.use('/api/projects', express.json(), projectStakeholdersRoutes);
app.use('/api/projects', express.json(), projectReadinessRoutes);
app.use('/api/projects', express.json(), projectHazardAssessmentRoutes);
app.use('/api/projects', express.json(), projectClimateRiskRoutes);
app.use('/api/projects', express.json(), projectEsohsgScreeningRoutes);
app.use('/api/projects', express.json(), projectPdfRoutes);
app.use('/api/project_photos', photoRouter);

// NEW: Mount the contractor-related routes as top-level resources
app.use('/api/contractors', express.json(), contractorRoutes);
// 🐛 FIX: This route handles multipart/form-data, so it does not need express.json()
app.use('/api/payment-requests', paymentRequestRoutes);
app.use('/api/contractor-photos', express.json(), contractorPhotoRoutes);
app.use('/api/hr', express.json(), hrRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

app.listen(port, () => {
    console.log(`KEMRI CRUD API listening at http://localhost:${port}`);
    console.log(`CORS enabled for specific origins during development.`);
});

module.exports = app;
