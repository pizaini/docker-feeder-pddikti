#!/bin/bash
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
echo "Start services..."
/etc/init.d/postgresql start

#Check installed version and compare then update
installed_version=sed -nr "/^\[config\]/ { :l /^last[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" /var/www/html/install.ini
#Update to 3.3
#if["3.3" != $installed_version]
#  then
#    echo "Updating to 3.3"
#fi

apachectl -D FOREGROUND