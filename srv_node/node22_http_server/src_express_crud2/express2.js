// npm install express sqlite3 body-parser

const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const db = new sqlite3.Database('./database.db');

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Create table if not exists
db.run(`
  CREATE TABLE IF NOT EXISTS items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    quantity INTEGER NOT NULL
  )
`);

// API Routes
// 1. Read all items
app.get('/api/items', (req, res) => {
  db.all('SELECT * FROM items', [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// 2. Create a new item
app.post('/api/items', (req, res) => {
  const { name, quantity } = req.body;
  db.run('INSERT INTO items (name, quantity) VALUES (?, ?)', [name, quantity], function (err) {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ id: this.lastID, name, quantity });
  });
});

// 3. Update an item
app.put('/api/items/:id', (req, res) => {
  const { id } = req.params;
  const { name, quantity } = req.body;
  db.run('UPDATE items SET name = ?, quantity = ? WHERE id = ?', [name, quantity, id], function (err) {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ updated: this.changes });
  });
});

// 4. Delete an item
app.delete('/api/items/:id', (req, res) => {
  const { id } = req.params;
  db.run('DELETE FROM items WHERE id = ?', [id], function (err) {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ deleted: this.changes });
  });
});

// Start server
app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});