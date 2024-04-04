FROM php:8.1-apache

# RUN apt-get update && apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y libmcrypt-dev libzip-dev zip cron libmagickwand-dev --no-install-recommends \
    && pecl install imagick  \
    && docker-php-ext-enable imagick  \
    && docker-php-ext-install gd zip intl

#RUN printf "\n" | pecl install imagick
#RUN docker-php-ext-enable imagick

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# composer about

RUN a2enmod rewrite
# service apache2 restart

EXPOSE 80