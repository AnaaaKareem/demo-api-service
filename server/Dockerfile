FROM node:20-slim

RUN apt-get update

WORKDIR /usr/local/app

COPY package*.json ./

RUN npm ci && \
 npm cache clean --force && \
 mv /usr/local/app/node_modules /node_modules

COPY . .

EXPOSE 8080

CMD ["node", "server.js"]