"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
//import express from 'express'
var express = require("express");
//const app = express()
var app = express();
var PORT = 3000;
app.use(express.json());
app.get('/', function (req, res) {
    res.send('Hello World!');
});
app.listen(PORT, function () {
    console.log('Server is listening on port ${PORT}');
});
//# sourceMappingURL=server.js.map