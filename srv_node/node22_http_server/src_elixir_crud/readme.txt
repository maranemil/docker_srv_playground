# start node container
docker run -it --rm --name my-running-script  --network=host -p 3000:3000 -v "$PWD":/usr/src/app -w /usr/src/app node:22 bash


npm install express sqlite3 elixir body-parser
npm i elixir

node elixir.js

Server running on http://localhost:3000
Connected to SQLite database.