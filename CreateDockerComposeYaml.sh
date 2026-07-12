#!/bin/bash

cat << 'EOF' > /root/japanese-flashcards/docker-compose.yml
version: '3.8'

services:
  frontend:
    build: ./frontend
    ports:
      - "8080:80"
    environment:
      - ROCKY_IP=${ROCKY_IP}
    restart: always

  backend:
    build: ./backend
    ports:
      - "3000:3000"
    volumes:
      - sqlite_data:/data:Z
    restart: always

volumes:
  sqlite_data:
EOF
