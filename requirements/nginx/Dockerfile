FROM	debian:bullseye

RUN	apt update && apt upgrade && apt install -y \
	nginx

#export port and copy conf file?
EXPOSE 80

CMD	["nginx", "-g", "daemon off;"]
