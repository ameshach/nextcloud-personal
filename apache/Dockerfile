FROM docker.io/library/ubuntu:latest

RUN apt update

RUN apt-get install -y tzdata

ENV TZ=Europe/Amsterdam

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN apt install apache2 -y


RUN apt install libapache2-mod-php php-bz2 php-gd php-mysql php-curl php-mbstring php-imagick php-zip php-ctype php-curl php-dom php-json php-posix php-bcmath php-xml php-intl php-gmp zip unzip wget -y

RUN a2enmod rewrite dir mime env headers


RUN cd /var/www/ \
   &&  wget https://download.nextcloud.com/server/releases/latest.zip \
   && unzip latest.zip \
   && rm -rf latest.zip \
   && chown -R www-data:www-data /var/www/nextcloud/ \
   && cd /var/www/nextcloud 

#RUN service apache2 start

#RUN tail -f  /var/log/apache2/access.log /var/log/apache2/error.log 

RUN apt install curl netcat -y

RUN wget -O /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh

RUN chmod +x /usr/local/bin/wait-for-it.sh

RUN sed -i 's#DocumentRoot /var/www/html#DocumentRoot /var/www/nextcloud#g' /etc/apache2/sites-enabled/000-default.conf

RUN apt install php8.1-fpm -y

RUN apt install php8.1-apcu sudo vim -y

RUN a2dismod php8.1 && a2dismod mpm_prefork && a2enmod mpm_event proxy_fcgi setenvif && a2enconf php8.1-fpm

RUN echo "upload_max_filesize = 64M \n post_max_size = 96M \n memory_limit = 512M  \n max_execution_time = 600 \n max_input_vars = 3000  \n max_input_time = 1000 " >> /etc/php/8.1/fpm/php.ini

RUN echo "pm.max_children = 64 \n pm.start_servers = 16 \n  pm.min_spare_servers = 16 \n  pm.max_spare_servers = 32 " >> /etc/php/8.1/fpm/pool.d/www.conf

COPY 000-default.conf /etc/apache2/sites-enabled/000-default.conf

RUN echo "<?php phpinfo(); ?>" >> /var/www/nextcloud/info.php

RUN echo "opcache.enable=1 \n opcache.enable_cli=1 \n opcache.interned_strings_buffer=8 \n opcache.max_accelerated_files=10000 \n opcache.memory_consumption=128 \n opcache.save_comments=1 \n opcache.revalidate_freq=60" >> /etc/php/8.1/fpm/php.ini

#RUN chown -R www-data:www-data /var/www/nextcloud/config

#COPY config.php /var/www/nextcloud/config/config.php

#RUN sudo -u www-data php occ maintenance:repair

COPY Startup-script.sh /Startup-script.sh

RUN chmod 755 /Startup-script.sh

CMD /Startup-script.sh > /dev/console

#CMD mkdir -p /var/www/nextcloud/data/ && touch /var/www/nextcloud/data/.ocdata &&  chown -R www-data:www-data /var/www/nextcloud && sudo -u www-data php /var/www/nextcloud/occ maintenance:repair && service php8.1-fpm start && service apache2 start && tail -f  /var/log/apache2/access.log /var/log/apache2/error.log



#CMD service apache2 start && cd /var/www/nextcloud && php occ  maintenance:install --database "mysql" --database-name "nextcloud"  --database-user "nextcloud" --database-pass "passw@rd" --admin-user "admin" --admin-pass "admin123" --database-host mysql && tail -f  /var/log/apache2/access.log /var/log/apache2/error.log