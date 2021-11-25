FROM debian:9.11
MAINTAINER Pizaini <github.com/pizaini>

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8

# Install Dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
            apt-transport-https \
            build-essential \
            ca-certificates \
            libssl-dev \
            zip \
            manpages \
            unzip \
            lsb-release \
            netbase \
            procps \
            libcurl3 \
            ucf \
            libedit2 \
            libx11-6\
            libpng16-16 \
            php-common \
            locales \
            libmagic1 \
            libfreetype6 \
            libfontconfig1 \
            libgd3 \
            libxml2 \
            supervisor

RUN locale-gen && localedef -i en_US -f UTF-8 en_US.UTF-8
#Apache environments
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2/httpd.pid
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/www

COPY scripts/run.sh /run.sh
COPY scripts/restore.sh /restore.sh
COPY scripts/ssl.sh /ssl.sh

RUN chmod +x /run.sh
RUN chmod +x /ssl.sh
RUN chmod +x /restore.sh

# COPY INSTALLER
RUN mkdir /feeder
COPY ./feeder-apps/* /feeder
#COPY data/postgresql.zip /feeder/postgresql.zip
#COPY data/html.zip /feeder/html.zip
#COPY data/psql_etc.zip /feeder/psql_etc.zip

WORKDIR /feeder
## INSTALL FEEDER 3.2
RUN unzip -qq Feeder_3.2_Amd64_Debian.zip
RUN chmod +x ./INSTALL

RUN ./INSTALL
RUN /bin/sh -c "/ssl.sh"

##BACKUP
RUN zip -r -q html.zip /var/www/html/
RUN zip -r -q postgresql_data.zip /var/lib/postgresql/
RUN zip -r -q postgresql_config.zip /etc/postgresql/

## PATCH 3.3
RUN unzip -qq Patch_3.3_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.3.3

## PATCH 3.4
RUN unzip -qq Patch_3.4_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.3.4

## PATCH 4.0
RUN unzip -qq Patch_4.0_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.4.0

## PATCH 4.1
RUN unzip -qq Patch_4.1_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.4.1

## Apache configs
COPY ssl/localhost.crt /feeder/ssl.crt
COPY ssl/localhost.key /feeder/ssl.key
COPY php-apache/conf/default-ssl.conf /feeder/default-ssl.conf

#Config supervisord
COPY scripts/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Web ports: http, https and postgresql
EXPOSE 80 8082 443 54321

WORKDIR /var/www/html
CMD ["/run.sh"]