#!/bin/bash

cat << 'EOF' > /root/japanese-flashcards/frontend/Dockerfile
FROM nginx:alpine
COPY index.html.template /usr/share/nginx/html/index.html.template
EXPOSE 80
# Substitute the IP at container boot time and start Nginx
CMD ["/bin/sh", "-c", "envsubst '${ROCKY_IP}' < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'"]
EOF
