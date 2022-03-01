echo "Restoring default database and web app..."

unzip -o -qq /feeder/postgresql_data.zip -d /
unzip -o -qq /feeder/postgresql_config.zip -d /
unzip -o -qq /feeder/html.zip -d /

echo "Change directory owner..."
chown postgres:postgres -R /var/lib/postgresql
chown postgres:postgres -R /etc/postgresql