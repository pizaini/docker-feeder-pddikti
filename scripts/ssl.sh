echo "Enable SSL..."
#Copy ssl config
cp /feeder/ssl.crt /etc/apache2/ssl.crt
cp /feeder/ssl.key /etc/apache2/ssl.key
cp /feeder/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

#Enable mods and site
a2enmod ssl
a2enmod headers
a2enmod rewrite
a2ensite default-ssl