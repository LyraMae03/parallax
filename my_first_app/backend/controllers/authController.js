
const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// REGISTER
const register = async (req, res) => {
    try {
        const {
            fullName,
            username,
            email,
            password,
            confirmPassword
        } = req.body;

        if (!fullName || !username || !email || !password || !confirmPassword) {
            return res.status(400).json({
                success: false,
                message: 'All fields are required.'
            });
        }

        const cleanName = fullName.trim();
        const cleanUsername = username.trim();
        const cleanEmail = email.trim().toLowerCase();

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(cleanEmail)) {
            return res.status(400).json({
                success: false,
                message: 'Please enter a valid email address.'
            });
        }

        if (!/^[a-zA-Z0-9_]{3,30}$/.test(cleanUsername)) {
            return res.status(400).json({
                success: false,
                message: 'Username must be 3-30 characters and contain only letters, numbers, or underscores.'
            });
        }

        if (password.length < 8) {
            return res.status(400).json({
                success: false,
                message: 'Password must be at least 8 characters.'
            });
        }

        if (password !== confirmPassword) {
            return res.status(400).json({
                success: false,
                message: 'Passwords do not match.'
            });
        }

        const [existingUsers] = await db.promise().execute(
            'SELECT id, username, email FROM users WHERE username = ? OR email = ?',
            [cleanUsername, cleanEmail]
        );

        if (existingUsers.length > 0) {
            const duplicateEmail = existingUsers.some(
                user => user.email.toLowerCase() === cleanEmail
            );

            return res.status(409).json({
                success: false,
                message: duplicateEmail
                    ? 'Email is already registered.'
                    : 'Username is already taken.'
            });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const [result] = await db.promise().execute(
            `INSERT INTO users
            (full_name, username, email, password_hash)
            VALUES (?, ?, ?, ?)`,
            [cleanName, cleanUsername, cleanEmail, hashedPassword]
        );

        return res.status(201).json({
            success: true,
            message: 'REVRSE account created successfully!',
            user: {
                id: result.insertId,
                fullName: cleanName,
                username: cleanUsername,
                email: cleanEmail
            }
        });

    } catch (error) {
        console.error('Registration Error:', error);

        return res.status(500).json({
            success: false,
            message: 'Something went wrong during registration.'
        });
    }
};

// LOGIN
const login = async (req, res) => {
    try {
        const { identity, password } = req.body;

        if (!identity || !password) {
            return res.status(400).json({
                success: false,
                message: 'Email/username and password are required.'
            });
        }

        const cleanIdentity = identity.trim();

        const [users] = await db.promise().execute(
            `SELECT id, full_name, username, email, password_hash
             FROM users
             WHERE email = ? OR username = ?
             LIMIT 1`,
            [cleanIdentity.toLowerCase(), cleanIdentity]
        );

        if (users.length === 0) {
            return res.status(401).json({
                success: false,
                message: 'Invalid email/username or password.'
            });
        }

        const user = users[0];

        const passwordMatch = await bcrypt.compare(
            password,
            user.password_hash
        );

        if (!passwordMatch) {
            return res.status(401).json({
                success: false,
                message: 'Invalid email/username or password.'
            });
        }

        const token = jwt.sign(
            { id: user.id },
            process.env.JWT_SECRET,
            { expiresIn: '7d' }
        );

        return res.status(200).json({
            success: true,
            message: 'Login successful!',
            token,
            user: {
                id: user.id,
                fullName: user.full_name,
                username: user.username,
                email: user.email
            }
        });

    } catch (error) {
        console.error('Login Error:', error);

        return res.status(500).json({
            success: false,
            message: 'Something went wrong during login.'
        });
    }
};

module.exports = { register, login };
