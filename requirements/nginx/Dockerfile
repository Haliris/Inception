FROM	debian:bullseye

RUN	apt-get update && apt-get -y upgrade && apt-get install -y nginx

#export port and copy conf file?
EXPOSE 80

CMD	["nginx", "-g", "daemon off;"]
