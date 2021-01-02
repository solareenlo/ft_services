#!/bin/sh

telegraf &
/usr/share/grafana/bin/grafana-server -homepath /usr/share/grafana -config /usr/share/grafana/conf/custom.ini
