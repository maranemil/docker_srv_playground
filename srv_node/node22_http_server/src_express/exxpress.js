const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.get('/about', (req, res) => {
  res.send('Welcome to about us page');
});

app.get('/contact', (req, res) => {
  res.send('Welcome to contact us page');
});

app.post('/', function (req, res) {
  res.send('Hello Geeks')
})

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

// https://www.geeksforgeeks.org/node-js/express-js/
// https://www.geeksforgeeks.org/node-js/routing-in-node-js/
// https://www.npmjs.com/package/express
// npm i express
// npm install -g npm@11.7.0
// node express.js
// Server is running on http://localhost:3000