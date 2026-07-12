#!/bin/bash

cat << 'EOF' > /root/jp-flashcards/backend/server.js
const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

// Connect to SQLite database in the mounted volume
const db = new sqlite3.Database('/data/flashcards.db', (err) => {
    if (!err) {
        db.run("CREATE TABLE IF NOT EXISTS cards (id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, created_at DATETIME DEFAULT CURRENT_TIMESTAMP)");
    }
});

// GET all flashcards
app.get('/api/cards', (req, res) => {
    db.all("SELECT * FROM cards ORDER BY created_at DESC", [], (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

// POST a new flashcard
app.post('/api/cards', (req, res) => {
    const { text } = req.body;
    if (!text) return res.status(400).json({ error: 'Text required' });
    
    db.run("INSERT INTO cards (text) VALUES (?)", [text], function(err) {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ id: this.lastID, text });
    });
});

// DELETE a flashcard
app.delete('/api/cards/:id', (req, res) => {
    db.run("DELETE FROM cards WHERE id = ?", req.params.id, (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ success: true });
    });
});

app.listen(3000, () => console.log('Backend API listening on port 3000'));
EOF
