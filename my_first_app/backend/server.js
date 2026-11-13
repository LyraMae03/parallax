
require('dotenv').config();

const express = require('express');
const cors = require('cors');
const db = require('./config/db');

const authRoutes = require('./routes/authRoutes');

const app = express();

app.use(cors());
app.use(express.json());

// Home route
app.get('/', (req, res) => {
    res.json({
        success: true,
        message: 'Welcome to REVRSE API!'
    });
});

// Authentication routes
app.use('/api/auth', authRoutes);

// Test database
app.get('/api/test-db', (req, res) => {
    db.query('SELECT DATABASE() AS database_name', (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: err.message
            });
        }

        res.json({
            success: true,
            database: results[0].database_name
        });
    });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`REVRSE API running on port ${PORT}`);
});
