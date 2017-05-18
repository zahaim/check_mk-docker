#!/bin/bash

set -e

if [ "${1:0:1}" = '-' ]; then
  set -- omd "$@"
fi

omd create $SITE --no-init -umonitoring -gmonitoring && \
omd config $SITE set TMPFS off && \
omd config $SITE set DEFAULT_GUI check_mk && \
omd config $SITE set APACHE_TCP_ADDR 0.0.0.0 && \
omd config $SITE set APACHE_TCP_PORT 5000 && \
omd config $SITE set LIVESTATUS_TCP on && \
omd config $SITE set LIVESTATUS_TCP_PORT 6557

service xinetd start

# Allow the user to run arbitrarily commands like bash
omd $@

pushd /omd/sites/$SITE
tail -f var/log/apache/access_log
