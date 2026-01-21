

# start node container
docker run -it --rm --name my-running-script  --network=host -p 3000:3000 -v "$PWD":/usr/src/app -w /usr/src/app node:22 bash

cd src
npm i http-server
npm run
node server.mjs 

# ufw allow 443
# set HTTPS=false && npm run

Listening on 127.0.0.1:3000

http://127.0.0.1:3000/
http://localhost:3000/

Hello World!