#!/bin/bash
chown -R ${FTP_USER}:${FTP_USER} /var/www/html && \
chmod -R 755 /var/www/html

/usr/sbin/vsftpd /etc/vsftpd.conf