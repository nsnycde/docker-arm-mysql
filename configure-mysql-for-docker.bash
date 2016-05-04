#!/usr/bin/env bash

## Enable external connections
sed -i 's/^bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

echo '' >> /etc/mysql/mysql.conf.d/mysqld.cnf
echo '[mysqld]' >> /etc/mysql/mysql.conf.d/mysqld.cnf

## Disable use of the internal host cache for faster name-to-IP resolution.
## In this case, the server performs a DNS lookup every time a client connects.
echo 'skip-host-cache' >> /etc/mysql/mysql.conf.d/mysqld.cnf

## Do not resolve host names when checking client connections.
## Use only IP addresses. If you use this option, all Host column values in the
## grant tables must be IP addresses or localhost.
echo 'skip-name-resolve' >> /etc/mysql/mysql.conf.d/mysqld.cnf

echo '' >> /etc/mysql/mysql.conf.d/mysqld.cnf
