FROM webdevops/php:8.4-alpine

ENV TIMEZONE=Asia/Jakarta
ENV APPLICATION_ENV=production
ENV APPLICATION_USER=application \
    APPLICATION_GROUP=application \
    APPLICATION_PATH=/app \
    APPLICATION_UID=1000 \
    APPLICATION_GID=1000
ENV WEB_DOCUMENT_ROOT=${APPLICATION_PATH} \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.local \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET=127.0.0.1:9000
ENV SERVICE_NGINX_CLIENT_MAX_BODY_SIZE="80m"
ENV PHP_DATE_TIMEZONE=${TIMEZONE}
ENV SKIP_COMPOSER=false

# set timezone
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone

# set php custom config
COPY src/php/8.4/conf/ /opt/docker/
COPY src/php/8.4/html/errors/ /var/www/errors/
COPY --chown=APPLICATION_USER:APPLICATION_GROUP src/php/8.4/www/ $APPLICATION_PATH/

# Install nginx
RUN set -x \
    && apk-install nginx \
    && docker-run-bootstrap

# Application user
USER $APPLICATION_USER

# Expose Ports.
EXPOSE 80 443

# set workdir
WORKDIR $APPLICATION_PATH
