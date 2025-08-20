#!/usr/bin/env bash

# Composer install
if [ "$SKIP_COMPOSER" != true ]; then
    # Try auto install for composer
    if [ -f "$APPLICATION_PATH/composer.json" ]; then
        if [ "$APPLICATION_ENV" == "development" ]; then
            composer install --working-dir="$APPLICATION_PATH"
            # Fix rights of vendor directory
            chown -R "$APPLICATION_USER:$APPLICATION_GROUP" "$APPLICATION_PATH/vendor"
            find "$APPLICATION_PATH/vendor" -type d -exec chmod 755 {} \;
            find "$APPLICATION_PATH/vendor" -type f -exec chmod 644 {} \;
        else
            composer install --optimize-autoloader --no-interaction --no-progress --working-dir="$APPLICATION_PATH"
            # Fix rights of vendor directory
            chown -R "$APPLICATION_USER:$APPLICATION_GROUP" "$APPLICATION_PATH/vendor"
            find "$APPLICATION_PATH/vendor" -type d -exec chmod 755 {} \;
            find "$APPLICATION_PATH/vendor" -type f -exec chmod 644 {} \;
        fi
    fi
fi
