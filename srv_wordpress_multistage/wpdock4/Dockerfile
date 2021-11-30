FROM wordpress:5.8.2-php8.0-apache AS BuilderDebBase80wp
RUN set -eux; \
    apt-get update
WORKDIR /usr/src/wordpress

############################################
# step2
############################################

FROM BuilderDebBase80wp AS WordPressBild

VOLUME /var/www/html

#WORKDIR /usr/src
#CMD rm /usr/src/*
#COPY wordpress-5.8.1.tar.gz /usr/src/wordpress.tar.gz
#RUN chmod 777 /usr/src/wordpress.tar.gz
#
## https://gist.github.com/bozdoz/4353103dd80bcb314503f9048cdb305c
## https://github.com/docker-library/wordpress/blob/master/Dockerfile.template
#
#ENV WORDPRESS_VERSION 5.8.1
#ENV WORDPRESS_SHA1 21e50add5a51cd9a18610244c942c08f7abeccd8
#
#RUN set -eux; \
#	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
#	\
## upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
#	tar -xzf wordpress.tar.gz -C /usr/src/; \
#	rm wordpress.tar.gz; \
#    chmod +x /usr/src/wordpress; \
#    # https://wordpress.org/support/article/htaccess/
#    [ ! -e /usr/src/wordpress/.htaccess ]; \
#    { \
#        echo '# BEGIN WordPress'; \
#        echo ''; \
#        echo 'RewriteEngine On'; \
#        echo 'RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]'; \
#        echo 'RewriteBase /'; \
#        echo 'RewriteRule ^index\.php$ - [L]'; \
#        echo 'RewriteCond %{REQUEST_FILENAME} !-f'; \
#        echo 'RewriteCond %{REQUEST_FILENAME} !-d'; \
#        echo 'RewriteRule . /index.php [L]'; \
#        echo ''; \
#        echo '# END WordPress'; \
#    } > /usr/src/wordpress/.htaccess; \
#    \
#    chown -R www-data:www-data /usr/src/wordpress; \
#    # pre-create wp-content (and single-level children) for folks who want to bind-mount themes, etc so permissions are pre-created properly instead of root:root
#    # wp-content/cache: https://github.com/docker-library/wordpress/issues/534#issuecomment-705733507
#    mkdir wp-content; \
#    for dir in /usr/src/wordpress/wp-content/*/ cache; do \
#        dir="$(basename "${dir%/}")"; \
#        mkdir "wp-content/$dir"; \
#    done; \
#    chown -R www-data:www-data wp-content; \
#    chown -R www-data:www-data /usr/src/*; \
#    chmod -R 777 wp-content
#
#
#
#
#COPY docker-entrypoint.sh /usr/local/bin/
#ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["apache2-foreground"]

#ADD src /var/www/html
#USER root

