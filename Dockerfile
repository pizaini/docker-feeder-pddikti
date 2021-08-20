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
        libxml2

RUN locale-gen && localedef -i en_US -f UTF-8 en_US.UTF-8
#Apache environments
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2/httpd.pid
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/www

COPY scripts/run.sh /run.sh
RUN chmod +x /run.sh

# COPY INSTALLER
RUN mkdir /feeder
COPY ./feeder-apps/* /feeder
COPY postgresql/postgresql.zip /feeder/postgresql.zip

# Apache configs
COPY ssl/localhost.crt /etc/apache2/ssl/ssl.crt
COPY ssl/localhost.key /etc/apache2/ssl/ssl.key
COPY php-apache/conf/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY php-apache/conf/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

#Enable necessary mods
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/headers.load
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load

## INSTALL FEEDER 3.2
WORKDIR /feeder
RUN unzip Feeder_3.2_Amd64_Debian.zip
RUN chmod +x ./INSTALL && ./INSTALL

## PATCH 3.3
RUN unzip Patch_3.3_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.3.3
RUN ./UPDATE_PATCH.3.3

## PATCH 3.4
RUN unzip Patch_3.4_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.3.4
RUN ./UPDATE_PATCH.3.4

## PATCH 4.0
RUN unzip Patch_4.0_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.4.0
RUN ./UPDATE_PATCH.4.0

## PATCH 4.1
RUN unzip Patch_4.1_Amd64_Linux.zip
RUN chmod +x ./UPDATE_PATCH.4.1
RUN ./UPDATE_PATCH.4.1

#Web ports
EXPOSE 80
EXPOSE 8082
EXPOSE 443
#Database port. Next, kita akan edit listening port postgres agar dapat diakses dari luar (non-localhost)
EXPOSE 54321

WORKDIR /var/www/html
CMD ["/run.sh"]