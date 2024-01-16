#!/bin/bash

set -x

echo "init opensips-cp db schema..."
mysql -u${DB_USER} -p${DB_PASSWORD} -h ${DB_HOST} -P ${DB_PORT} -D${DB_NAME} <config/db_schema.mysql
