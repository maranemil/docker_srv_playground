################################################################
# nginx
################################################################
# https://hub.docker.com/_/nginx

FROM nginx
COPY static-html-directory /usr/share/nginx/html
CMD ["nginx-debug", "-g", "daemon off;"]