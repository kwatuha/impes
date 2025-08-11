// src/routes/projectMapRoutes.js
const express = require('express');
const router = express.Router();
const pool = require('../config/db'); // Import the database connection pool


/**
 * @file API service for Project Map related calls.
 * @description Handles fetching project map data, including GeoJSON and associated project details.
 */

// --- CRUD Operations for Project Maps (kemri_project_maps) ---

/**
 * @route GET /api/projects/project_maps
 * @description Get all project maps with optional geographical filters.
 * The response includes the filtered project data and a
 * bounding box to facilitate map panning and zooming.
 * @query {string} countyId - Filter by a specific county ID.
 * @query {string} subcountyId - Filter by a specific subcounty ID.
 * @query {string} wardId - Filter by a specific ward ID.
 */
router.get('/', async (req, res) => {
    try {
        // Extract optional query parameters
        const { countyId, subcountyId, wardId } = req.query;

        // UPDATED: Base query to fetch project maps with a JOIN to get project details.
        let query = `
            SELECT 
                pm.*,
                p.projectName,
                p.projectDescription,
                p.costOfProject,
                p.status
            FROM 
                kemri_project_maps pm
            JOIN
                kemri_projects p ON pm.projectId = p.id
            WHERE 1=1
        `;

        const queryParams = [];

        // Dynamically build the WHERE clause based on the provided filters
        // The subqueries check the junction tables for associations.
        if (countyId) {
            query += `
                AND pm.projectId IN (
                    SELECT projectId FROM kemri_project_counties WHERE countyId = ?
                )
            `;
            queryParams.push(countyId);
        }
        if (subcountyId) {
            query += `
                AND pm.projectId IN (
                    SELECT projectId FROM kemri_project_subcounties WHERE subcountyId = ?
                )
            `;
            queryParams.push(subcountyId);
        }
        if (wardId) {
            query += `
                AND pm.projectId IN (
                    SELECT projectId FROM kemri_project_wards WHERE wardId = ?
                )
            `;
            queryParams.push(wardId);
        }
        
        console.log('Executing SQL Query:', query);
        console.log('With Parameters:', queryParams);

        const [rows] = await pool.query(query, queryParams);
        
        if (rows.length === 0) {
            return res.status(200).json({ data: [], boundingBox: null });
        }

        let allCoordinates = [];
        
        const filteredData = rows.map(item => {
            let geoJson;
            try {
                geoJson = JSON.parse(item.map);
                
                if (geoJson.features && geoJson.features.length > 0) {
                    geoJson.features.forEach(feature => {
                        if (feature.geometry && feature.geometry.coordinates) {
                            const geometryType = feature.geometry.type;
                            if (geometryType === 'Point') {
                                allCoordinates.push(feature.geometry.coordinates);
                            } else if (geometryType === 'MultiPoint' || geometryType === 'LineString') {
                                allCoordinates.push(...feature.geometry.coordinates);
                            } else if (geometryType === 'Polygon' || geometryType === 'MultiPolygon') {
                                const coords = feature.geometry.coordinates[0];
                                if (coords) {
                                    allCoordinates.push(...coords);
                                }
                            }
                        }
                    });
                }
            } catch (e) {
                console.error("Error parsing GeoJSON for item:", item, e);
                return null;
            }
            return { ...item, parsedMap: geoJson };
        }).filter(item => item !== null);

        const boundingBox = allCoordinates.reduce((acc, [lng, lat]) => {
            acc.minLat = Math.min(acc.minLat, lat);
            acc.minLng = Math.min(acc.minLng, lng);
            acc.maxLat = Math.max(acc.maxLat, lat);
            acc.maxLng = Math.max(acc.maxLng, lng);
            return acc;
        }, {
            minLat: Infinity,
            minLng: Infinity,
            maxLat: -Infinity,
            maxLng: -Infinity,
        });

        const finalBoundingBox = (boundingBox.minLat === Infinity) ? null : boundingBox;

        res.status(200).json({ data: filteredData, boundingBox: finalBoundingBox });

    } catch (error) {
        console.error('Error fetching project maps:', error);
        res.status(500).json({ message: 'Error fetching project maps', error: error.message });
    }
});

// The rest of your routes from the original code remain unchanged.
/**
 * @route GET /api/projects/project_maps/:id
 * @description Get a single project map by ID.
 */
router.get('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [rows] = await pool.query('SELECT * FROM kemri_project_maps WHERE mapId = ?', [id]);
        if (rows.length > 0) {
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project map not found' });
        }
    } catch (error) {
        console.error('Error fetching project map:', error);
        res.status(500).json({ message: 'Error fetching project map', error: error.message });
    }
});

/**
 * @route POST /api/projects/project_maps
 * @description Create a new project map.
 */
router.post('/', async (req, res) => {
    const newMap = {
        // We no longer manually create the mapId here.
        // The database will handle the AUTO_INCREMENT for the mapId field.
        voided: false,
        voidedBy: null,
        ...req.body
    };
    // Ensure the client doesn't send an ID to prevent conflicts
    delete newMap.mapId;
    
    try {
        const [result] = await pool.query('INSERT INTO kemri_project_maps SET ?', newMap);

        // Fetch the newly created record using the auto-generated insertId
        const [rows] = await pool.query('SELECT * FROM kemri_project_maps WHERE mapId = ?', [result.insertId]);
        if (rows.length > 0) {
            res.status(201).json(rows[0]);
        } else {
            // Fallback if fetching the new record fails
            res.status(201).json({ mapId: result.insertId, message: 'Map data created successfully' });
        }
    } catch (error) {
        console.error('Error creating project map:', error);
        res.status(500).json({ message: 'Error creating project map', error: error.message });
    }
});

/**
 * @route POST /api/projects/project_maps/import
 * @description Import generic map data for various resources.
 * The request body should contain `resourceType`, `resourceId` OR `resourceName`, and `geojson`.
 * @body {string} resourceType - The type of resource ('projects', 'participants', 'poles').
 * @body {number} resourceId - The ID of the resource to update. Required if resourceType is not 'projects' or if resourceName is not provided.
 * @body {string} geojson - The GeoJSON data as a string.
 */
router.post('/import', async (req, res) => {
    const { resourceType, resourceId, resourceName, geojson } = req.body;

    if (!resourceType || !geojson) {
        return res.status(400).json({ message: 'Missing required fields: resourceType, geojson' });
    }

    const resourceMap = {
        'projects': { table: 'kemri_projects', nameColumn: 'projectName' },
        'participants': { table: 'kemri_participants', idColumn: 'participantId' },
        'poles': { table: 'kemri_poles', idColumn: 'poleId' },
    };

    const resource = resourceMap[resourceType];
    if (!resource) {
        return res.status(400).json({ message: `Invalid resourceType: ${resourceType}` });
    }

    try {
        let idToUpdate;
        let finalResourceId;

        if (resourceType === 'projects') {
            if (!resourceName) {
                return res.status(400).json({ message: 'resourceName is required for resourceType "projects".' });
            }
            const [projectRows] = await pool.query(`SELECT id FROM kemri_projects WHERE projectName = ?`, [resourceName]);
            if (projectRows.length === 0) {
                return res.status(404).json({ message: `Project with name "${resourceName}" not found.` });
            }
            finalResourceId = projectRows[0].id;
        } else if (resourceId) {
            idToUpdate = parseInt(resourceId, 10);
            if (isNaN(idToUpdate)) {
                return res.status(400).json({ message: 'resourceId must be a valid number.' });
            }
            finalResourceId = idToUpdate;
        } else {
            return res.status(400).json({ message: 'A resourceId or resourceName must be provided.' });
        }

        const insertQuery = 'INSERT INTO kemri_project_maps (projectId, map) VALUES (?, ?)';
        const insertParams = [finalResourceId, geojson];

        const [result] = await pool.query(insertQuery, insertParams);

        if (result.affectedRows > 0) {
            res.status(201).json({ message: `Map data for ${resourceType} with ID ${finalResourceId} inserted successfully.`, newMapId: result.insertId });
        } else {
            res.status(500).json({ message: `Failed to insert map data for ${resourceType} with ID ${finalResourceId}.` });
        }
    } catch (error) {
        console.error(`Error importing map data for ${resourceType}:`, error);
        res.status(500).json({ message: 'Error processing GeoJSON or updating database.', error: error.message });
    }
});

/**
 * @route PUT /api/projects/project_maps/:id
 * @description Update an existing project map.
 */
router.put('/:id', async (req, res) => {
    const { id } = req.params;
    const updatedFields = { ...req.body };
    try {
        const [result] = await pool.query('UPDATE kemri_project_maps SET ? WHERE mapId = ?', [updatedFields, id]);
        if (result.affectedRows > 0) {
            const [rows] = await pool.query('SELECT * FROM kemri_project_maps WHERE mapId = ?', [id]);
            res.status(200).json(rows[0]);
        } else {
            res.status(404).json({ message: 'Project map not found' });
        }
    } catch (error) {
        console.error('Error updating project map:', error);
        res.status(500).json({ message: 'Error updating project map', error: error.message });
    }
});

/**
 * @route DELETE /api/projects/project_maps/:id
 * @description Delete a project map.
 */
router.delete('/:id', async (req, res) => {
    const { id } = req.params;
    try {
        const [result] = await pool.query('DELETE FROM kemri_project_maps WHERE mapId = ?', [id]);
        if (result.affectedRows > 0) {
            res.status(204).send();
        } else {
            res.status(404).json({ message: 'Project map not found' });
        }
    } catch (error) {
        console.error('Error deleting project map:', error);
        res.status(500).json({ message: 'Error deleting project map', error: error.message });
    }
});

module.exports = router;
