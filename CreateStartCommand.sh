#!/bin/bash

cat << 'EOF' > /root/japanese-flashcards/start.sh
#!/bin/bash

# Extract the primary IP address used for outbound internet traffic
export ROCKY_IP=$(ip route get 1.1.1.1 | awk '{print $7; exit}')

echo "--> Detected Host IP: ${ROCKY_IP}"

# Launch the stack using the dynamic variable
docker compose up -d --build
EOF
chmod +x /root/japanese-flashcards/start.sh
