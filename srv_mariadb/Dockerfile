FROM bitnami/mariadb:latest
ENV ALLOW_EMPTY_PASSWORD=yes
ENV MARIADB_USER=admin
ENV MARIADB_PASSWORD=test
ENV MARIADB_DATABASE=test_db
COPY *.sql /docker-entrypoint-initdb.d/