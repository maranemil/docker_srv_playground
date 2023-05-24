# https://serverfault.com/questions/961150/docker-with-apache2-and-php-5-6-mysqli-pdo-extension-installed-but-not-enabl

#FROM php:8.0.10-apache as base
FROM php:8.1-apache as base

FROM base as final
RUN apt-get -y update && apt-get upgrade -y

# Install tools && libraries
RUN apt-get -y install --fix-missing apt-utils nano wget curl dialog libonig-dev \
    build-essential git curl libcurl4-openssl-dev libzip-dev zip \
    libmagickwand-dev libmagickcore-dev\
    libmcrypt-dev libsqlite3-dev libsqlite3-0 default-mysql-client \
    zlib1g-dev libicu-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHP5 Extensions
RUN docker-php-ext-install curl \
#    && docker-php-ext-install tokenizer \
#    && docker-php-ext-install json \
#    && docker-php-ext-install mcrypt \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pdo_sqlite \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-ext-install -j$(nproc) intl \
#    && docker-php-ext-install mbstring \
    && docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install imagick \
 && docker-php-ext-enable imagick

RUN docker-php-ext-install exif

# Enable apache modules
RUN a2enmod rewrite headers

#WORKDIR /var/www/html
#COPY /html .

RUN echo "extension=pdo_mysql" >> /usr/local/etc/php/php.ini \
 && service apache2 restart

EXPOSE 8081

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
