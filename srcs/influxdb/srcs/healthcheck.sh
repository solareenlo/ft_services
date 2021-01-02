#/bin/sh

count=`ps aux | grep telegraf | grep -v grep | wc -l`
if [ $count = 0 ]; then
	exit 1
fi

count=`ps aux | grep influxd | grep -v grep | wc -l`
if [ $count = 0 ]; then
	exit 1
fi
