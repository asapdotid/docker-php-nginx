# Composer install
if [ "$SKIP_COMPOSER" != true ]; then
    # Try auto install for composer
    if [ -f "$CONTAINER_WORKDIR_PATH/composer.json" ]; then
        if [ "$APPLICATION_ENV" == "development" ]; then
            composer install --working-dir=$CONTAINER_WORKDIR_PATH
        else
            composer install --optimize-autoloader --no-interaction --no-progress --working-dir=$CONTAINER_WORKDIR_PATH
        fi
    fi
fi
