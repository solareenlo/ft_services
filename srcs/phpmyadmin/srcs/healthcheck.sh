#/bin/sh

ps aux | grep telegraf || exit 1
ps aux | grep php-fpm || exit 1
ps aux | grep nginx || exit 1
