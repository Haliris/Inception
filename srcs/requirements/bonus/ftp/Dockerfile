FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y vsftpd

ARG	FTP_USER
ARG	FTP_PASS

COPY	conf/vsftpd.conf /etc/vsftpd.conf
COPY	tools/entrypoint.sh /entrypoint.sh

RUN	mkdir -p /var/www/html

RUN	adduser --disabled-password --gecos "" "${FTP_USER}" && \
	echo "${FTP_USER}:${FTP_PASS}" | chpasswd

RUN	mkdir -p /var/run/vsftpd/empty
RUN	chmod 755 /var/run/vsftpd/empty
RUN	chown root:root /var/run/vsftpd/empty

RUN	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

RUN	chmod +x /entrypoint.sh

EXPOSE	20
EXPOSE	21 30000-30010

ENTRYPOINT	["/entrypoint.sh"]
#CMD	["tail", "-f", "/dev/null"]
