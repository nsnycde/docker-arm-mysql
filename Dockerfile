FROM arm32v7/ubuntu:xenial

MAINTAINER James Bacon james@baconi.co.uk

USER root

## Create mysql user early to keep UID/GUID consistent
RUN groupadd -r mysql && useradd -r -g mysql mysql

## Set the mysql version to install
ENV MYSQL_MAJOR 5.7

## Upload the scripts
COPY *.*sh /opt/docker-arm-mysql/

## Install MySQL
## Run MySQL configuration for docker script
## Run script to initialize MySQL
RUN /opt/docker-arm-mysql/install-mysql.bash && \
    /opt/docker-arm-mysql/configure-mysql-for-docker.bash && \
    /opt/docker-arm-mysql/initialise-mysql-insecure.bash

## Setup MySQL data directory as a volume
VOLUME /var/lib/mysql

## Set the entrypoint script, used to configure depending on requirements.
ENTRYPOINT ["/opt/docker-arm-mysql/docker-entrypoint.bash"]

## Expose the MySQL port
EXPOSE 3306

## Set the default command to be the MySQL daemon
CMD ["mysqld"]
