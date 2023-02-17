FROM node:14

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
#COPY package*.json ./
COPY ["package.json", "package-lock.json*", "./"]

#RUN npm install --force
RUN yarn install --force
RUN yarn upgrade --force
#RUN yarn audit --verbose

# If you are building your code for production
# RUN npm ci --only=production
# Bundle app source
#COPY . .

EXPOSE 3000
#CMD [ "node", "server.js" ]