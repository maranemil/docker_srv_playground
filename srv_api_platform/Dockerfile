FROM php:7.4-fpm
RUN apt-get update && apt-get install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip


WORKDIR /app
COPY app .

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN curl -sS https://get.symfony.com/cli/installer | bash

RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
RUN apt install symfony-cli -y

#RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony
#RUN symfony server:ca:install
#ADD composer.json composer.lock ./
#RUN composer install
#ADD . .
#RUN ./bin/console cache:clear
#CMD ["symfony", "server:start", "--no-tls"]