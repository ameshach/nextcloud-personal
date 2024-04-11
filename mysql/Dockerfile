FROM docker.io/library/ubuntu:latest

RUN apt update

RUN apt-get install -y tzdata 

ENV TZ=Europe/Amsterdam

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install mariadb-server -y

# Copy MySQL configuration file
COPY my.cnf /etc/mysql/my.cnf

# Expose the MySQL port
EXPOSE 3306

RUN sed -i 's/^# port = 3306$/port = 3306/' /etc/mysql/my.cnf


RUN sed -i 's/executing mysqld_safe/executing mysqld_safe\nexec 1>>\/dev\/console 2>>\/dev\/console/' /usr/bin/mysqld_safe

RUN apt install netcat -y

COPY mysql_Script.sql /mysql_Script.sql

COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

CMD /entrypoint.sh

#CMD ["sh", "-c", "/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --log-error=/var/log/mysql/error.log --user=mysql; sleep 10; mysql -uroot < /mysql_Script.sql"]

#CMD ["sh", "-c", "/usr/bin/mysqld_safe --defaults-file=/etc/mysql/my.cnf --datadir=/var/lib/mysql --pid-file=/var/run/mysqld/mysqld.pid --log-error=/var/log/mysql/error.log --user=mysql"]
