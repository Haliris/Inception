FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y vsftpd

ARG	FTP_USER
ARG	FTP_PASS

COPY	conf/vsftpd.conf /etc/vsftpd.conf

RUN	useradd -m -d /home/${FTP_USER} -s /bin/bash ${FTP_USER} && \
	echo "${FTP_USER}:${FTP_PASS}" | chpasswd && \
	mkdir -p /home/${FTP_USER}/wordpress && \
	chmod -R 755 /home/${FTP_USER}/wordpress && \
	chown -R ${FTP_USER}:${FTP_USER} /home/${FTP_USER}/wordpress

RUN	mkdir -p /var/run/vsftpd/empty
RUN	chmod 755 /var/run/vsftpd/empty
RUN	chown root:root /var/run/vsftpd/empty

RUN	echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

EXPOSE	21 30000-30100

CMD	["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
#CMD	["tail", "-f", "/dev/null"]
