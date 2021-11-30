FROM php:7.3-apache-buster AS BuilderDebBase

# https://github.com/docker-library/wordpress/blob/master/latest/php7.3/apache/Dockerfile
# install the PHP extensions we need
RUN set -eux; \
	savedAptMark="$(apt-mark showmanual)"; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libjpeg-dev \
		libpng-dev \
        libzip-dev \
    	zlib1g-dev \
        libfreetype6-dev \
        imagemagick \
        libmagickwand-dev \
        libmagickcore-dev \
	; \
	\
	pecl install imagick xdebug; \
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd exif mysqli opcache zip pdo pdo_mysql; \
    docker-php-ext-enable imagick xdebug; \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
    ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*


RUN a2enmod rewrite expires


# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php


RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	  } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
        echo "upload_max_filesize = 1024M"; \
        echo "max_execution_time = 600"; \
        echo "post_max_size = 128M"; \
        echo "memory_limit = 2G"; \
      } > /usr/local/etc/php/conf.d/uploads.ini

RUN { \
      echo "zend_extension=xdebug.so"; \
      echo "xdebug.client_host=host.docker.internal"; \
      echo "xdebug.mode=off"; \
      echo "xdebug.start_with_request=yes"; \
      echo "xdebug.idekey=PHPSTORM"; \
      } > /usr/local/etc/php/conf.d/xdebug.ini


# https://github.com/docker-library/wordpress/issues/420
# https://github.com/keystonejs/keystone/issues/4339 \
# https://wordpress.org/support/article/editing-wp-config-php/#configure-error-logging

RUN { \
        echo "error_reporting = 4339"; \
        echo "display_errors = Off"; \
        echo "display_startup_errors = Off"; \
        echo "log_errors = On"; \
        echo "error_log = /tmp/php_error.log"; \
        echo "log_errors_max_len = 1024"; \
        echo "ignore_repeated_errors = On"; \
        echo "ignore_repeated_source = Off"; \
        echo "html_errors = Off"; \
        } > /usr/local/etc/php/conf.d/error.ini



############################################
# step2
############################################

FROM BuilderDebBase AS WordPressBild
WORKDIR /usr/src
CMD rm /usr/src/*
COPY wordpress-5.8.1.tar.gz /usr/src/wordpress.tar.gz
RUN chmod 777 /usr/src/wordpress.tar.gz

# https://gist.github.com/bozdoz/4353103dd80bcb314503f9048cdb305c
# https://github.com/docker-library/wordpress/blob/master/Dockerfile.template

ENV WORDPRESS_VERSION 5.8.1
ENV WORDPRESS_SHA1 21e50add5a51cd9a18610244c942c08f7abeccd8

RUN set -eux; \
	echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c -; \
	\
# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
	tar -xzf wordpress.tar.gz -C /usr/src/; \
	rm wordpress.tar.gz; \
    chmod +x /usr/src/wordpress; \
    # https://wordpress.org/support/article/htaccess/
    [ ! -e /usr/src/wordpress/.htaccess ]; \
    { \
        echo '# BEGIN WordPress'; \
        echo ''; \
        echo 'RewriteEngine On'; \
        echo 'RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]'; \
        echo 'RewriteBase /'; \
        echo 'RewriteRule ^index\.php$ - [L]'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-f'; \
        echo 'RewriteCond %{REQUEST_FILENAME} !-d'; \
        echo 'RewriteRule . /index.php [L]'; \
        echo ''; \
        echo '# END WordPress'; \
    } > /usr/src/wordpress/.htaccess; \
    \
    chown -R www-data:www-data /usr/src/wordpress; \
    # pre-create wp-content (and single-level children) for folks who want to bind-mount themes, etc so permissions are pre-created properly instead of root:root
    # wp-content/cache: https://github.com/docker-library/wordpress/issues/534#issuecomment-705733507
    mkdir wp-content; \
    for dir in /usr/src/wordpress/wp-content/*/ cache; do \
        dir="$(basename "${dir%/}")"; \
        mkdir "wp-content/$dir"; \
    done; \
    chown -R www-data:www-data wp-content; \
    chown -R www-data:www-data /usr/src/*; \
    chmod -R 777 wp-content


VOLUME /var/www/html

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]

#ADD src /var/www/html
#USER root

