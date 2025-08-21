#!/usr/bin/env bash

# Modify application user
groupmod -g "$APPLICATION_GID" "$APPLICATION_GROUP" && usermod -u "$APPLICATION_UID" -g "$APPLICATION_GID" "$APPLICATION_USER"
