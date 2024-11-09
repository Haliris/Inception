FROM	debian:bullseye

RUN	sudo apt-get update && sudo apt-get install mariadb-server mariadb-client -y
RUN	sudo systemctl enable mariadb && sudo systemctl start mariadb

RUN	sudo systemctl status mariadb


