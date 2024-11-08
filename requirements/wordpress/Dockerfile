FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y php-fpm

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]

