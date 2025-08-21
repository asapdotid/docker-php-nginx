#!/usr/bin/env bash

# Fix permissions
chown -R "$APPLICATION_USER:$APPLICATION_GROUP" "$APPLICATION_PATH"
find "$APPLICATION_PATH" -type d -exec chmod 755 {} \;
find "$APPLICATION_PATH" -type f -exec chmod 644 {} \;
