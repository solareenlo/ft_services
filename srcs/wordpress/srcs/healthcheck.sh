#/bin/sh

ps aux | grep telegraf | grep -v grep || exit 1
ps aux | grep php-fpm | grep -v grep || exit 1
ps aux | grep nginx | grep -v grep || exit 1
