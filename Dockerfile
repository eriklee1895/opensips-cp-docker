FROM ubuntu:20.04

RUN apt-get update && apt-get install -y tzdata

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get install -y \
    mysql-client \
    apache2 libapache2-mod-php php-curl \
    php php-mysql php-gd php-pear php-cli php-apcu \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html
ADD opensips-cp-9.3.2.tar.gz /var/www/html
RUN mv opensips-cp-9.3.2 opensips-cp

ENV OPENSIPS_CP_PATH=/var/www/html/opensips-cp

# config apache server
COPY config/apache2-opensips-cp.conf /etc/apache2/sites-available/opensips-cp.conf
COPY entrypoint.sh init-db-schema.sh ${OPENSIPS_CP_PATH}/

RUN chown -R www-data:www-data ${OPENSIPS_CP_PATH}/ \
    && cp ${OPENSIPS_CP_PATH}/config/tools/system/smonitor/opensips_stats_cron /etc/cron.d/ \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2dissite 000-default.conf \
    && a2ensite opensips-cp.conf

WORKDIR ${OPENSIPS_CP_PATH}

EXPOSE 80
ENTRYPOINT ["./entrypoint.sh"]
