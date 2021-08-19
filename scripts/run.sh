#!/bin/bash
if [ "$(ls -A /var/lib/postgresql)" ]
  then
    echo "Database data already exist..."
  else
    echo "Database data does not exist. Copying default data..."
    unzip -o -qq /feeder/postgresql.zip -d /var/lib
fi

#change directory owner
chown www-data:www-data -R /home/prefill
chown postgres:postgres -R /var/lib/postgresql

#start services
/etc/init.d/postgresql start
apache2 -D FOREGROUND