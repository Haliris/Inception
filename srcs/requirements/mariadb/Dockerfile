FROM	debian:bullseye

RUN	 apt-get update -y &&  apt-get upgrade -y &&  apt-get install mariadb-server mariadb-client -y

COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	tools/script.sh ./
RUN	chmod 777 ./script.sh

RUN	mkdir -p /var/run/mysqld && \
	chown mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld
	
EXPOSE	3306

ENTRYPOINT ["script.sh"]
CMD ["mysqld"]
