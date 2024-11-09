FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y nginx
RUN	apt-get install vim -y
RUN	apt-get install curl -y

RUN	mkdir -p /etc/nginx/ssl
RUN	apt-get install OpenSSL -y && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=PARIS/0=42/0U=42/CN=login.42.fr/UID=login"
RUN	mkdir -p /var/run/nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

RUN	chmod 755 /var/www/html
RUN	chown -R www-data:www-data /var/www/html

#export port and copy conf file?
EXPOSE 80

CMD	["nginx", "-g", "daemon off;"]
