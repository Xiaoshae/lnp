#!/bin/sh


init_scrip="$1";
shift

"$init_scrip" "$@"

if [ $? -ne 0 ]; then
    exit 1
fi

exec docker-php-entrypoint php-fpm &
php_pid=$!

exec /docker-entrypoint.sh nginx -g "daemon off;" &
nginx_pid=$!

trap " kill -SIGTERM $nginx_pid ; wait $nginx_pid ; kill -SIGTERM $php_pid ; wait $php_pid " SIGTERM

wait
