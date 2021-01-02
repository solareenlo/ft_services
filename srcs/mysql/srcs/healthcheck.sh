#/bin/sh

ps aux | grep telegraf || exit 1
ps aux | grep mysqld || exit 1
