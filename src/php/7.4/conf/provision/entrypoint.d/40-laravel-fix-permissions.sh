#!/usr/bin/env bash

# Fix permissions Laravel storage
if [ -d "$APPLICATION_PATH/storage" ]; then
    chown -R "$APPLICATION_USER:$APPLICATION_GROUP" "$APPLICATION_PATH/storage"
    chmod -R 775 "$APPLICATION_PATH/storage"
    find "$APPLICATION_PATH/storage" -type d -exec chmod 775 {} \;
    find "$APPLICATION_PATH/storage" -type f -exec chmod 664 {} \;
fi

# Fix permissions Laravel cache
if [ -d "$APPLICATION_PATH/bootstrap/cache" ]; then
    chown -R "$APPLICATION_USER:$APPLICATION_GROUP" "$APPLICATION_PATH/bootstrap/cache"
    chmod -R 775 "$APPLICATION_PATH/bootstrap/cache"
    find "$APPLICATION_PATH/bootstrap/cache" -type d -exec chmod 775 {} \;
    find "$APPLICATION_PATH/bootstrap/cache" -type f -exec chmod 664 {} \;
fi
