FROM	debian:bullseye

RUN	 apt-get update -y &&  apt-get upgrade -y &&  apt-get install mariadb-server mariadb-client -y

RUN	mkdir -p /var/run/mysqld && \
	chown mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld
	
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./tools/script.sh /usr/local/bin

RUN	chmod +x /usr/local/bin/script.sh

EXPOSE	3306

ENTRYPOINT ["usr/local/bin/script.sh"]
CMD ["mysqld"]
