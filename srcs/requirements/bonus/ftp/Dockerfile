FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y vsftpd

ARG	FTP_USER
ARG	FTP_PASS

RUN	useradd -m -d /home/$FTP_USER -s /bin/bash $FTP_USER && \
	echo "$FTP_USER:$FTP_PASS" | chpasswd && \
	mkdir -p /home/$FTP_USER/wordpress && \
	chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/wordpress

COPY	conf/vsftpd.conf /etc/vsftpd.conf

EXPOSE	21 21000-21010

CMD	["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
