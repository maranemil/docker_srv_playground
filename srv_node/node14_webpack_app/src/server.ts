//import express from 'express'
import express = require('express');
//const app = express()
const app: express.Application = express();
const PORT = 3000
app.use(express.json())
app.get('/', (req, res) => {
  res.send('Hello World!')
})
app.listen(PORT, () => {
  console.log('Server is listening on port ')
})