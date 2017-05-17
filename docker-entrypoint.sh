#!/bin/bash

set -e

if [ "${1:0:1}" = '-' ]; then
  set -- omd "$@"
fi

service xinetd start

# Allow the user to run arbitrarily commands like bash
omd $@

tail -f var/log/apache/access_log
