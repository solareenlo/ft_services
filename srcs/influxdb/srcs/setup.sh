#!/usr/bin/env ash

if [ -z "$(ls -A -- /var/lib/influxdb)" ]; then
	INFLUXDB_HTTP_BIND_ADDRESS=127.0.0.1:8086
	INFLUXDB_HTTP_HTTPS_ENABLED=false
	influxd &
	until influx -host 127.0.0.1 -port 8086 -execute "CREATE DATABASE ${INFLUXDB_DATABASE}"; do
		echo waiting for influxdb; sleep 1;
	done
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
    # Shutdown influxd
	pkill influxd
fi

influxd
