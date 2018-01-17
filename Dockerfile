FROM webdevops/php-nginx:alpine-php7
WORKDIR /app
COPY ./composer.json ./composer.lock /app/
RUN composer install
ENV WEB_DOCUMENT_ROOT=/app/public
COPY ./public /app/public
