#!/bin/bash
set -x
mkdir -p /var/www/nextcloud/data/ 
#touch /var/www/nextcloud/data/.ocdata
chown -R www-data:www-data /var/www/nextcloud 
cd /var/www/nextcloud
sudo -u www-data php occ  maintenance:install --database "mysql" --database-name "nextcloud"  --database-user "nextcloud" --database-pass "passw@rd" --admin-user "admin" --admin-pass "admin123" --database-host mysql
if [ $? == 1 ]
then
echo "starting in repair mode"
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair
fi
service php8.1-fpm start
service apache2 start
tail -f  /var/log/apache2/access.log /var/log/apache2/error.log