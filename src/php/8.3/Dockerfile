FROM webdevops/php:8.3-alpine

ENV CONTAINER_WORKDIR_PATH=/app
ENV WEB_DOCUMENT_ROOT=${CONTAINER_WORKDIR_PATH} \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.local \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="80m"
ENV TIMEZONE=Asia/Jakarta
ENV PHP_DATE_TIMEZONE=${TIMEZONE}
ENV APPLICATION_ENV=production
ENV SKIP_COMPOSER=false

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# set php custom config
COPY src/php/8.3/conf/ /opt/docker/
COPY src/php/8.3/html/errors/ /var/www/errors/
COPY src/php/8.3/www/ $CONTAINER_WORKDIR_PATH/

# Install nginx
RUN set -x \
    && apk-install nginx \
    && docker-run-bootstrap

# Expose Ports.
EXPOSE 80 443

# set workdir
WORKDIR $CONTAINER_WORKDIR_PATH
