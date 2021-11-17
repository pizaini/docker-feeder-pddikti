#!/bin/bash
set -e

if [ "$(ls -A /var/lib/postgresql)" ]
  then
    echo "Database data already exist..."
  else
    echo "Database data does not exist. Copying default data..."
    unzip -o -qq /feeder/postgresql.zip -d /var/lib
    echo "Change directory db owner..."
    chown postgres:postgres -R /var/lib/postgresql
fi

#change directory owner
echo "Change directory prefill owner..."
chown www-data:www-data -R /home/prefill

#start services
echo "Start database..."
/etc/init.d/postgresql start
#
##Check installed version and compare then update
#installed_version=echo sed -nr "/^\[config\]/ { :l /^last[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /var/www/html/install.ini
#
##Update to 3.3
#if[$installed_version -le 3.3]
#  then
#    echo "Updating to 3.3"
#    ./UPDATE_PATCH.3.3
#fi
#
##Update to 3.4
#if[$installed_version -le 3.4]
#  then
#    echo "Updating to 3.4"
#    ./UPDATE_PATCH.3.4
#fi
#
##Update to 4.0
#if[$installed_version -le 4.0]
#  then
#    echo "Updating to 4.0"
#    ./UPDATE_PATCH.4.0
#fi
#
##Update to 4.1
#if[$installed_version -le 4.1]
#  then
#    echo "Updating to 4.1"
#    ./UPDATE_PATCH.4.1
#fi

echo "Start web server..."
supervisord