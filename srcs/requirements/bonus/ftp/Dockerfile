FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y vsftpd

ARG	FTP_USER
ARG	FTP_PASS

COPY	conf/vsftpd.conf /etc/vsftpd.conf

RUN	mkdir -p /var/www/html

RUN	adduser --disabled-password --gecos "" "${FTP_USER}" && \
	echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
	chown -R ${FTP_USER}:${FTP_USER} /var/www/html && \
	chmod -R 755 /var/www/html

RUN	mkdir -p /var/run/vsftpd/empty
RUN	chmod 755 /var/run/vsftpd/empty
RUN	chown root:root /var/run/vsftpd/empty

RUN	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

EXPOSE	20
EXPOSE	21 30000-30010

CMD	["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
#CMD	["tail", "-f", "/dev/null"]
