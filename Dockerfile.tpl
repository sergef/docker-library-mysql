FROM %DOCKER_REGISTRY%docker-library-alpine

MAINTAINER Serge Fomin <serge.fo@gmail.com>

WORKDIR /usr
EXPOSE 3306

RUN apk update \
  && apk add \
    mysql \
    mysql-client
RUN rm -rf /tmp/* /var/cache/apk/*
RUN mkdir -p /run/mysqld
RUN mysql_install_db

COPY config.sql /usr/config.sql

CMD /usr/bin/mysqld \
  --datadir=/var/lib/mysql \
  --user=root \
  --bind-address=0.0.0.0 \
  --init-file=/usr/config.sql
