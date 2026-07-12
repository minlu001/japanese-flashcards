#!/bin/bash

cat << 'EOF' > /root/japanese-flashcards/backend/Dockerfile
FROM node:18-alpine
WORKDIR /app
RUN npm install express sqlite3 cors
COPY server.js .
EXPOSE 3000
CMD ["node", "server.js"]
EOF
