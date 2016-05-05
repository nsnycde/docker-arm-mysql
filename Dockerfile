FROM armhf/ubuntu:xenial

MAINTAINER James Bacon james@baconi.co.uk

USER root

## Create mysql user early to keep UID/GUID consistent
RUN groupadd -r mysql && useradd -r -g mysql mysql

## Set the mysql version to install
ENV MYSQL_MAJOR 5.7

## Install MySQL
COPY install-mysql.bash /opt/docker-arm-mysql/
RUN /opt/docker-arm-mysql/install-mysql.bash

## Configuration MySQL for docker script
COPY configure-mysql-for-docker.bash /opt/docker-arm-mysql/
RUN /opt/docker-arm-mysql/configure-mysql-for-docker.bash

## Initialize MySQL
COPY initialise-mysql-insecure.bash /opt/docker-arm-mysql/
RUN /opt/docker-arm-mysql/initialise-mysql-insecure.bash

## Load timezones into MySQL
COPY load-timezones-into-mysql.bash /opt/docker-arm-mysql/
RUN /opt/docker-arm-mysql/load-timezones-into-mysql.bash

## Setup MySQL data directory as a volume
VOLUME /var/lib/mysql

## Upload docker entrypoint script
COPY docker-entrypoint.sh /opt/docker-arm-mysql/

## Set the entrypoint script, used to configure depending on requirements.
ENTRYPOINT ["/opt/docker-arm-mysql/docker-entrypoint.sh"]

## Expose the MySQL port
EXPOSE 3306

## Set the default command to be the MySQL daemon
CMD ["mysqld"]
