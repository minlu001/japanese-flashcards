FROM node:18-alpine
WORKDIR /app
RUN npm install express sqlite3 cors kuroshiro kuroshiro-analyzer-kuromoji
COPY server.js .
EXPOSE 3000
CMD ["node", "server.js"]
