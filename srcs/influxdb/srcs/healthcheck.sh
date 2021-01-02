#/bin/sh

ps aux | grep telegraf | grep -v grep || exit 1
ps aux | grep influxd | grep -v grep || exit 1
