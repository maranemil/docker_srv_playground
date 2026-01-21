// npm install express sqlite3 body-parser ejs
// node crud.js

const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const db = new sqlite3.Database('./database.db');

// Middleware
app.use(bodyParser.urlencoded({ extended: true }));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Create "users" table if it doesn't exist
db.run(`
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL
  )
`);

// Routes

// 1. List all users
app.get('/', (req, res) => {
  db.all('SELECT * FROM users', (err, rows) => {
    if (err) return res.status(500).send('Database error');
    res.render('index', { users: rows });
  });
});

// 2. Show form to create a new user
app.get('/create', (req, res) => {
  res.render('create');
});

// 3. Handle form submission to create a new user
app.post('/create', (req, res) => {
  const { name, email } = req.body;
  db.run('INSERT INTO users (name, email) VALUES (?, ?)', [name, email], (err) => {
    if (err) return res.status(500).send('Database error');
    res.redirect('/');
  });
});

// 4. Show form to edit a user
app.get('/edit/:id', (req, res) => {
  const { id } = req.params;
  db.get('SELECT * FROM users WHERE id = ?', [id], (err, row) => {
    if (err) return res.status(500).send('Database error');
    res.render('edit', { user: row });
  });
});

// 5. Handle form submission to update a user
app.post('/edit/:id', (req, res) => {
  const { id } = req.params;
  const { name, email } = req.body;
  db.run('UPDATE users SET name = ?, email = ? WHERE id = ?', [name, email, id], (err) => {
    if (err) return res.status(500).send('Database error');
    res.redirect('/');
  });
});

// 6. Delete a user
app.get('/delete/:id', (req, res) => {
  const { id } = req.params;
  db.run('DELETE FROM users WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).send('Database error');
    res.redirect('/');
  });
});

// Start the server
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});
