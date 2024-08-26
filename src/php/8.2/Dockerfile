FROM webdevops/php:8.2-alpine

ENV CONTAINER_WORKDIR_PATH=/app
ENV WEB_DOCUMENT_ROOT=${CONTAINER_WORKDIR_PATH} \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.local \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=""
ENV WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="50m"
ENV TIMEZONE=Asia/Jakarta
ENV PHP_DATE_TIMEZONE=${TIMEZONE}
ENV APPLICATION_ENV=production
ENV SKIP_COMPOSER=false

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# Install nginx
RUN set -x \
    && apk-install \
    nginx \
    && docker-run-bootstrap

# set php custom config
COPY src/php/8.2/conf/ /opt/docker/
COPY src/php/8.2/html/errors/ /var/www/errors/
COPY src/php/8.2/www/ $CONTAINER_WORKDIR_PATH/

# Expose Ports.
EXPOSE 80 443

# set workdir
WORKDIR $CONTAINER_WORKDIR_PATH
