#!/bin/bash

set -x

if [ -z "$DB_DRIVER" ]; then
    DB_DRIVER="mysql"
fi

if [[ ! -z "$DB_DRIVER" ]]; then
    sed -i 's/$config->db_driver = ".*";/$config->db_driver = "'$DB_DRIVER'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

if [[ ! -z "$DB_HOST" ]]; then
    sed -i 's/$config->db_host = ".*";/$config->db_host = "'$DB_HOST'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

if [[ ! -z "$DB_PORT" ]]; then
    sed -i 's/$config->db_port = ".*";/$config->db_port = "'$DB_PORT'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

if [[ ! -z "$DB_USER" ]]; then
    sed -i 's/$config->db_user = ".*";/$config->db_user = "'$DB_USER'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

if [[ ! -z "$DB_PASSWORD" ]]; then
    sed -i 's/$config->db_pass = ".*";/$config->db_pass = "'$DB_PASSWORD'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

if [[ ! -z "$DB_NAME" ]]; then
    sed -i 's/$config->db_name = ".*";/$config->db_name = "'$DB_NAME'";/g' ${OPENSIPS_CP_PATH}/config/db.inc.php
fi

sh init-db-schema.sh

exec apache2ctl -D FOREGROUND
