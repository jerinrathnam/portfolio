FROM ubuntu

RUN apt-get install inginx

WORKDIR /var/www/html/

COPY . .