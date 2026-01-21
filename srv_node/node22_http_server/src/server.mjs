// server.mjs
import http from 'http';
// https://www.npmjs.com/package/http-server

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  //res.end('Hello World!\n');
  // https://www.geeksforgeeks.org/node-js/routing-in-node-js/
  const url = req.url;
  if (url === '/about') {
    res.write(' Welcome to about us page');
    res.end();
  }
  else if (url === '/contact') {
    res.write(' Welcome to contact us page');
    res.end();
  }
  else {
    res.write('Hello World!');
    res.end();
  }
});

// starts a simple http server locally on port 3000
server.listen(3000, '127.0.0.1', () => {
  console.log('Listening on 127.0.0.1:3000');
});
// run with `node server.mjs`