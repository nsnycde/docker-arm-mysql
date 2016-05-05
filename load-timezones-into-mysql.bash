#!/usr/bin/env bash

## Start the MySQL daemon
"$@" --skip-networking &
pid="$!"

## MySQL command
mysql=( mysql --protocol=socket -uroot )

## Wait until MySQL has started up
for i in {30..0}; do
  if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
    break
  fi
  echo 'MySQL init process in progress...'
  sleep 1
done
if [ "$i" = 0 ]; then

  ## Dump the MySQL error logs if they exist
  [ -f /var/log/mysql/error.log ] && cat >&2 /var/log/mysql/error.log

  echo >&2 'MySQL init process failed.'
  exit 1
fi

## Load timezones into MySQL
if [ -z "$MYSQL_INITDB_SKIP_TZINFO" ]; then
  echo 'Loading timezones into MySQL'
  # sed is for https://bugs.mysql.com/bug.php?id=20545
  mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/FCTY/' | "${mysql[@]}" mysql
fi

## Stop the MySQL daemon
if ! kill -s TERM "$pid" || ! wait "$pid"; then
  echo >&2 'MySQL init process failed.'
  exit 1
fi
