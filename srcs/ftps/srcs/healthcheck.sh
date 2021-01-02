#/bin/sh

ps aux | grep telegraf | grep -v grep || exit 1
ps aux | grep vsftpd | grep -v grep || exit 1
