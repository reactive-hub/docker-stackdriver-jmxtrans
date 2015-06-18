#!/bin/bash
set -e

if [ ! -z ${STACKDRIVER_API_KEY+x} ]; then
  find /opt/jmxtrans/conf -type f -name '*.json' -exec sed -i 's#STACKDRIVER_API_KEY#'$STACKDRIVER_API_KEY'#' {} \;
fi

if [ ! -z ${JMX_HOST+x} ]; then
  find /opt/jmxtrans/conf -type f -name '*.json' -exec sed -i 's#JMX_HOST#'$JMX_HOST'#' {} \;
fi

if [ ! -z ${JMX_PORT+x} ]; then
  find /opt/jmxtrans/conf -type f -name '*.json' -exec sed -i 's#JMX_PORT#'$JMX_PORT'#' {} \;
fi

if [ "$1" == "jmxtrans" ]; then
  exec java -Djmxtrans.log.dir='/opt/jmxtrans/log' -jar /opt/jmxtrans/jmxtrans-all.jar -j /opt/jmxtrans/conf/
else
  exec "$@"
fi
