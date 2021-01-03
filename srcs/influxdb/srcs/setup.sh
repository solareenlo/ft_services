#!/bin/sh

if [ -z "$(ls -A /var/lib/influxdb)" ]; then
	influxd & until influx -execute exit </dev/null >/dev/null 2>&1; do sleep 1; echo -n '.'; done
	influx -execute "CREATE DATABASE ${INFLUXDB_DATABASE}"
    # Create admin user
    influx -execute "CREATE USER \"${INFLUXDB_ADMIN_USERNAME}\" WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
    # Authenticate as admin
    INFLUX_USERNAME=${INFLUXDB_ADMIN_USERNAME}
    INFLUX_PASSWORD=${INFLUXDB_ADMIN_PASSWORD}
    # Create telegraf user with write privileges
    influx -execute "CREATE USER \"${INFLUXDB_TELEGRAF_USERNAME}\" WITH PASSWORD '${INFLUXDB_TELEGRAF_PASSWORD}'"
    influx -execute "GRANT WRITE ON \"${INFLUXDB_DATABASE}\" TO \"${INFLUXDB_TELEGRAF_USERNAME}\""
    # Create grafana user with read privileges
	influx -execute "CREATE USER \"${INFLUXDB_GRAFANA_USERNAME}\" WITH PASSWORD '${INFLUXDB_GRAFANA_PASSWORD}'"
    influx -execute "GRANT READ ON \"${INFLUXDB_DATABASE}\" TO \"${INFLUXDB_GRAFANA_USERNAME}\""
	pkill influxd
fi

telegraf &
influxd
