FROM nginx:alpine

COPY index.html.template /usr/share/nginx/html/index.html.template

EXPOSE 80

CMD ["/bin/sh", "-c", "envsubst '${ROCKY_IP}' < /usr/share/nginx/html/index.html.template > /usr/share/nginx/html/index.html && exec nginx -g 'daemon off;'"]
