const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const authenticate = require('./middleware/authenticate');
const cors = require('cors');
const path = require('path');

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
const projectDocumentsRoutes = require('./routes/projectDocumentsRoutes');
const workflowRoutes = require('./routes/projectWorkflowRoutes');
const approvalLevelsRoutes = require('./routes/approvalLevelsRoutes');
const paymentStatusRoutes = require('./routes/paymentStatusRoutes');


const port = 3000;

const corsOptions = {
  origin: '*',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204
};
app.use(cors(corsOptions));

app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, '..', 'uploads')));

app.get('/', (req, res) => {
    res.send('Welcome to the KEMRI CRUD API!');
});

app.use('/api/auth', authRoutes);
app.use('/api', authenticate);

// IMPORTANT: Order these from most specific to most general where there's a possibility of conflict.
// In this case, payment-requests has a specific dynamic route that could be shadowed.
app.use('/api/payment-requests', paymentRequestRoutes);
app.use('/api/projects', projectRoutes);
app.use('/api/users', userRoutes);
app.use('/api/organization', orgRoutes);
app.use('/api/strategy', strategyRoutes);
app.use('/api/participants', participantRoutes);
app.use('/api/general', generalRoutes);
app.use('/api/dashboard', dashboardRoutes);
app.use('/api/metadata', metaDataRoutes);
app.use('/api/tasks', taskRoutes);
app.use('/api/milestones', milestoneRoutes);
app.use('/api/task_assignees', taskAssigneesRoutes);
app.use('/api/task_dependencies', taskDependenciesRoutes);
app.use('/api/project_photos', photoRouter);
app.use('/api/contractors', contractorRoutes);
app.use('/api/contractor-photos', contractorPhotoRoutes);
app.use('/api/hr', hrRoutes);
app.use('/api/projects/documents', projectDocumentsRoutes);
app.use('/api/workflows', workflowRoutes);
app.use('/api/approval-levels', approvalLevelsRoutes);
app.use('/api/payment-status', paymentStatusRoutes);
app.use('/api/projects', projectConceptNoteRoutes);
app.use('/api/projects', projectNeedsAssessmentRoutes);
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
app.use('/api/projects', projectPdfRoutes);


app.use((err, req, res, next) => {
    console.error(err.stack);
    const statusCode = err.statusCode || 500;
    const errorMessage = err.message || 'An unexpected error occurred.';
    res.status(statusCode).json({
        message: errorMessage,
        stack: process.env.NODE_ENV === 'development' ? err.stack : undefined,
    });
});

app.listen(port, () => {
    console.log(`KEMRI CRUD API listening at http://localhost:${port}`);
    console.log(`CORS enabled for specific origins during development.`);
});

module.exports = app;