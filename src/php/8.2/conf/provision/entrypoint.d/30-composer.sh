#!/usr/bin/env bash

# Composer install
if [ "$SKIP_COMPOSER" != true ]; then
    # Try auto install for composer
    if [ -f "$CONTAINER_WORKDIR_PATH/composer.json" ]; then
        if [ "$APPLICATION_ENV" == "development" ]; then
            composer install --working-dir="$CONTAINER_WORKDIR_PATH"
            # Fix rights of vendor directory
            chown -R "$APPLICATION_UID:$APPLICATION_GID" "$CONTAINER_WORKDIR_PATH/vendor"
            find "$CONTAINER_WORKDIR_PATH/vendor" -type d -exec chmod 755 {} \;
            find "$CONTAINER_WORKDIR_PATH/vendor" -type f -exec chmod 644 {} \;
        else
            composer install --optimize-autoloader --no-interaction --no-progress --working-dir="$CONTAINER_WORKDIR_PATH"
            # Fix rights of vendor directory
            chown -R "$APPLICATION_UID:$APPLICATION_GID" "$CONTAINER_WORKDIR_PATH/vendor"
            find "$CONTAINER_WORKDIR_PATH/vendor" -type d -exec chmod 755 {} \;
            find "$CONTAINER_WORKDIR_PATH/vendor" -type f -exec chmod 644 {} \;
        fi
    fi
fi
