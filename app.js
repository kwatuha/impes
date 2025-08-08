// app.js
const express = require('express');
const bodyParser = require('body-parser');
const authenticate = require('./middleware/authenticate'); // Authentication middleware
const cors = require('cors'); // Import cors

// Import route groups
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const projectRoutes = require('./routes/projectRoutes'); // Core project routes
const orgRoutes = require('./routes/orgRoutes');
const strategyRoutes = require('./routes/strategyRoutes');
const participantRoutes = require('./routes/participantRoutes');
const generalRoutes = require('./routes/generalRoutes');
const dashboardRoutes = require('./routes/dashboardRoutes');
const metaDataRoutes = require('./routes/metaDataRoutes');

const taskRoutes = require('./routes/taskRoutes');
const milestoneRoutes = require('./routes/milestoneRoutes');
const taskAssigneesRoutes = require('./routes/taskAssigneesRoutes');
const taskDependenciesRoutes = require('./routes/taskDependenciesRoutes');
const publicStrategyRoutes = require('./routes/publicStrategyRoutes'); // For public strategic planning routes (e.g., template download)

// NEW: Import new modular project-related routes
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
const projectPdfRoutes = require('./routes/projectPdfRoutes'); // NEW: Import the new PDF route file


const app = express();
const port = 3000;

// --- CORS Configuration ---
const corsOptions = {
  origin: [
    'http://localhost:5173',
    'http://127.0.0.1:5173',
    'http://localhost:3000',
    'http://192.168.100.12:5173',
  ],
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204
};
app.use(cors(corsOptions));

// Middleware for parsing JSON bodies
app.use(bodyParser.json());

// --- Serve static files from the 'uploads' directory ---
app.use('/uploads', express.static('uploads'));

// Root route
app.get('/', (req, res) => {
    res.send('Welcome to the KEMRI CRUD API!');
});

// --- Public Routes (No Authentication Required) ---
app.use('/api/auth', authRoutes);
app.use('/api/strategy', publicStrategyRoutes); // Public strategic planning routes (e.g., template download)

// --- Protected Routes (Authentication Required) ---
app.use('/api', authenticate); // This middleware will now protect all routes below it

// Use the grouped routes (these will now be protected)
app.use('/api/users', userRoutes);
app.use('/api/projects', projectRoutes); // Core project routes
app.use('/api/organization', orgRoutes);
app.use('/api/strategy', strategyRoutes); // Protected strategic planning routes
app.use('/api/participants', participantRoutes);
app.use('/api/general', generalRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/metadata', metaDataRoutes);

app.use('/api/tasks', taskRoutes);
app.use('/api/milestones', milestoneRoutes);
app.use('/api/task_assignees', taskAssigneesRoutes);
app.use('/api/task_dependencies', taskDependenciesRoutes);

// NEW: Mount the new modular project-related routes
app.use('/api/projects', projectConceptNoteRoutes);
app.use('/api/projects', projectNeedsAssessmentRoutes);
app.use('/api/projects', projectFinancialsRoutes);
app.use('/api/projects', projectFyBreakdownRoutes);
app.use('/api/projects', projectSustainabilityRoutes);
app.use('/api/projects', projectImplementationPlanRoutes);
app.use('/api/projects', projectMAndERoutes);
app.use('/api/projects', projectRisksRoutes);
app.use('/api/projects', projectStakeholdersRoutes);
app.use('/api/projects', projectReadinessRoutes);
app.use('/api/projects', projectHazardAssessmentRoutes);
app.use('/api/projects', projectClimateRiskRoutes);
app.use('/api/projects', projectEsohsgScreeningRoutes);
app.use('/api/projects', projectPdfRoutes); // NEW: Mount the PDF export route

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Start the server
app.listen(port, () => {
    console.log(`KEMRI CRUD API listening at http://localhost:${port}`);
    console.log(`CORS enabled for specific origins during development.`);
});
