FROM	debian:bullseye

RUN	sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get install mariadb-server mariadb-client -y
RUN	sudo systemctl enable mariadb && sudo systemctl start mariadb

RUN	sudo systemctl status mariadb

COPY	conf/50-server.cnd /etc/mysql/mariadb.conf.d/50-server.cnf
