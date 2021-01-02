#/bin/sh

ps aux | grep telegraf || exit 1
ps aux | grep grafana-server || exit 1
