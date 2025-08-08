// backend/config/db.js
const mysql = require('mysql2/promise');
require('dotenv').config(); // Load environment variables (like DB_HOST, DB_USER, etc.)

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT || 3306, // Use port from .env or default to 3306
    waitForConnections: true,
    connectionLimit: 10, // Adjust as needed for your expected load
    queueLimit: 0,
    charset: 'utf8mb4'
});

// Optional: Test the connection pool immediately on startup
pool.getConnection()
  .then(connection => {
    console.log('MySQL connection pool created and tested successfully xxx from db.js!');
    connection.release(); // Release the connection immediately after testing
  })
  .catch(err => {
    console.error('Error connecting to MySQL database from db.js:', err);
    process.exit(1); // Exit the application if database connection fails
  });

module.exports = pool; // This is the crucial line: Export the pool for other files to use