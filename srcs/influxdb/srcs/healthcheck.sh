#/bin/sh

ps aux | grep telegraf || exit 1
ps aux | grep influxd || exit 1
