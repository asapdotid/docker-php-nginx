#!/usr/bin/env bash

# Fix permissions
chown -R "$APPLICATION_UID:$APPLICATION_GID" "$CONTAINER_WORKDIR_PATH"
