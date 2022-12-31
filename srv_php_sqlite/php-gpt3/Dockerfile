
FROM php:7.4-fpm

# Install PHP extensions
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip

# Set the working directory
WORKDIR /var/www/html

# Copy the application code
COPY . .

# Expose port 9000 and start PHP-FPM server
EXPOSE 9000
CMD ["php-fpm"]
