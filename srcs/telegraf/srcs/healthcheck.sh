#/bin/sh

ps aux | grep telegraf | grep -v grep || exit 1
