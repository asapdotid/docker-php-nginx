# Docker Image PHP and Nginx

-   Base image: `webdevops/php`
-   OS image: Alpine Linux v3.16 & v3.18

Setup docker image multiple platform [Docs](https://docs.docker.com/build/building/multi-platform/)

-   amd64
-   arm64

PHP & Nginx (stable) Version:

-   PHP: 8.2 & NGINX: 1.24.0
-   PHP: 8.1 & NGINX: 1.24.0
-   PHP: 7.4 & NGINX: 1.22.1

**PHP** Socket port: `127.0.0.1:9000`

**Nginx** open port: `80` and `443`

## Custum stuff

-   Add composer entrypoint (composer.json) base of app env `development` or `production`
-   Timezone set to `Asia/Jakarta`

## To Do's

-   ✅ Manual build Docker image
-   ✅ Manual publish Docker image
-   ⬜ Automatic build Docker image (GitHub workflows)
-   ⬜ Automatic publish Docker image (GitHub workflows)

## Makefile Commands

Helping utility commands for simple build and push Docker image.

### Help command:

```bash
make help
```

### Build docker image:

```bash
make build VER=8.2
```

Or

```bash
make build VER=8.2 TAG=latest
```

### Publish docker image to docker hub:

Before publish image, first login to docker hub via cli:

```bash
docker login
```

Publish docker image:

```bash
make push VER=8.2
```

Or

```bash
make push VER=8.2 TAG=latest
```

## Image Environment

### PHP modules

As we build our images containing almost every PHP module and having it
activated by default, you might want to deactivate some.

You can specify a comma-separated list of unwanted modules as dynamic
env variable `PHP_DISMOD`, e.g. `PHP_DISMOD=ioncube,redis`.

### PHP.ini variables

You can specify eg. `php.memory_limit=256M` as dynamic env variable
which will set `memory_limit = 256M` as php setting.

| Environment variable                  | Description                             | Default   |
| ------------------------------------- | --------------------------------------- | --------- |
| `php.{setting-key}`                   | Sets the `{setting-key}` as php setting |           |
| `PHP_DATE_TIMEZONE`                   | `date.timezone`                         | `UTC`     |
| `PHP_DISPLAY_ERRORS`                  | `display_errors`                        | `0`       |
| `PHP_MEMORY_LIMIT`                    | `memory_limit`                          | `512M`    |
| `PHP_MAX_EXECUTION_TIME`              | `max_execution_time`                    | `300`     |
| `PHP_POST_MAX_SIZE`                   | `post_max_size`                         | `50M`     |
| `PHP_UPLOAD_MAX_FILESIZE`             | `upload_max_filesize`                   | `50M`     |
| `PHP_OPCACHE_MEMORY_CONSUMPTION`      | `opcache.memory_consumption`            | `256`     |
| `PHP_OPCACHE_MAX_ACCELERATED_FILES`   | `opcache.max_accelerated_files`         | `7963`    |
| `PHP_OPCACHE_VALIDATE_TIMESTAMPS`     | `opcache.validate_timestamps`           | `default` |
| `PHP_OPCACHE_REVALIDATE_FREQ`         | `opcache.revalidate_freq`               | `default` |
| `PHP_OPCACHE_INTERNED_STRINGS_BUFFER` | `opcache.interned_strings_buffer`       | `16`      |

### PHP FPM variables

You can specify eg. `fpm.pool.pm.max_requests=1000` as dyanmic env
variable which will sets `pm.max_requests = 1000` as fpm pool setting.
The prefix `fpm.pool` is for pool settings and `fpm.global` for global
master process settings.

<table>
<thead>
<tr class="header">
<th>Environment variable</th>
<th>Description</th>
<th>Default</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p><code>fpm.global.{setting-key}</code></p>
<p><code>fpm.pool.{setting-key}</code></p></td>
<td><p>Sets the <code>{setting-key}</code> as fpm global setting for the
master process Sets the <code>{setting-key}</code> as fpm pool
setting</p></td>
<td></td>
</tr>
<tr class="even">
<td><code>FPM_PROCESS_MAX</code></td>
<td><code>process.max</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="odd">
<td><code>FPM_PM_MAX_CHILDREN</code></td>
<td><code>pm.max_children</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="even">
<td><code>FPM_PM_START_SERVERS</code></td>
<td><code>pm.start_servers</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="odd">
<td><code>FPM_PM_MIN_SPARE_SERVERS</code></td>
<td><code>pm.min_spare_servers</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="even">
<td><code>FPM_PM_MAX_SPARE_SERVERS</code></td>
<td><code>pm.max_spare_servers</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="odd">
<td><code>FPM_PROCESS_IDLE_TIMEOUT</code></td>
<td><code>pm.process_idle_timeout</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="even">
<td><code>FPM_MAX_REQUESTS</code></td>
<td><code>pm.max_requests</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="odd">
<td><code>FPM_REQUEST_TERMINATE_TIMEOUT</code></td>
<td><code>request_terminate_timeout</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="even">
<td><code>FPM_RLIMIT_FILES</code></td>
<td><code>rlimit_files</code></td>
<td><code>distribution default</code></td>
</tr>
<tr class="odd">
<td><code>FPM_RLIMIT_CORE</code></td>
<td><code>rlimit_core</code></td>
<td><code>distribution default</code></td>
</tr>
</tbody>
</table>

### Composer

Due to the incompatibilities between composer v1 and v2 we introduce a
simple mechanism to switch between composer versions.

| Environment variable | Description                         | Default |
| -------------------- | ----------------------------------- | ------- |
| `COMPOSER_VERSION`   | Specify the composer version to use | `2`     |

#### Additional custom environment

| Environment variable | Description                                               | Default        |
| -------------------- | --------------------------------------------------------- | -------------- |
| `APPLICATION_ENV`    | Specify the application env `development` or `production` | `production`   |
| `SKIP_COMPOSER`      | Installation in application                               | `false`        |
| `TIMEZONE`           | Timezone                                                  | `Asia/Jakarta` |

## Docker Compose setup (Laravel)

```yaml
# compose.yml
version: "3.7"

services:
    application:
        image: docker.io/asapdotid/php:8.1
        expose:
            - 9000
        networks:
            - application-net
        environment:
            - PHP_POST_MAX_SIZE=100M
            - PHP_UPLOAD_MAX_FILESIZE=100M
        volumes:
            - ./projects/laravel:/app
            - ./conf/supervisor/laravel.conf:/etc/supervisor/conf.d/laravel.conf

networks:
    application-net:
        name: application-net
        driver: bridge
```

### Supervisor Config for Laravel (`laravel.conf`)

Place config to `/etc/supervisor/conf.d/laravel.conf`

```ini
[group:laravel-worker]
priority=999
programs=laravel-schedule,laravel-notification,laravel-queue

[program:laravel-schedule]
numprocs=1
autostart=true
autorestart=true
redirect_stderr=true
process_name=%(program_name)s_%(process_num)02d
command=/usr/local/bin/php /app/artisan schedule:run
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:laravel-notification]
numprocs=1
autostart=true
autorestart=true
redirect_stderr=true
process_name=%(program_name)s_%(process_num)02d
command=/usr/local/bin/php /app/artisan notification:worker
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:laravel-queue]
numprocs=5
autostart=true
autorestart=true
redirect_stderr=true
process_name=%(program_name)s_%(process_num)02d
command=/usr/local/bin/php /app/artisan queue:work sqs --sleep=3 --tries=3
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

### Running Docker Composer

```bash
docker composer up -d
```

## License

MIT / BSD

## Author Information

This Code was created in 2023 by [Asapdotid](https://github.com/asapdotid).
