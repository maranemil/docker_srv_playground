# https://stackoverflow.com/questions/54360223/openshift-nginx-permission-problem-nginx-emerg-mkdir-var-cache-nginx-cli
# https://hub.docker.com/_/nginx
# https://newbedev.com/openshift-nginx-permission-problem-nginx-emerg-mkdir-var-cache-nginx-client-temp-failed-13-permission-denied
# https://chrisgunnelsprogramming.code.blog/2020/02/16/nginx-error-emerg-mkdir-var-cache-nginx-client_temp-failed-13-permission-denied/

FROM nginx:alpine

LABEL maintainer="ReliefMelone"

WORKDIR /app
COPY . .

# Install node.js
RUN apk update && \
    apk add nodejs npm python make curl g++


# Build Application
#RUN npm install
#RUN ./node_modules/@angular/cli/bin/ng build --configuration=${BUILD_CONFIG}
#RUN cp -r ./dist/. /usr/share/nginx/html

# Configure NGINX
#COPY ./openshift/nginx/nginx.conf /etc/nginx/nginx.conf
#COPY ./openshift/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
#
#RUN chown -R $UID:$GID /var/cache/nginx/client_temp
#
#RUN chgrp -R root /var/cache/nginx /var/run /var/log/nginx && \
#    chmod -R 770 /var/cache/nginx /var/run /var/log/nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

# https://github.com/nginxinc/docker-nginx/issues/524

#FROM nginx:alpine
#COPY application /usr/share/nginx/html
#COPY ./entrypoint.sh /
#CMD ./entrypoint.sh
#EXPOSE 80

# chown -R $UID:$GID /var/cache/nginx/client_temp