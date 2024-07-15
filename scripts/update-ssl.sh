#!/bin/bash

GENERATE_SSL_SCRIPT="./generate_certification.sh"
NGINX_CONTAINER_NAME="nginx"
# 1 week
TIMEOUT=60
# TIMEOUT=604800
# 24 hours
RETRY_TIMEOUT=10
# RETRY_TIMEOUT=86400
MAX_RETRY=3

attempt=0

function execute() {
   printf "\nStart generate ssl certificates\n"
   current_datetime=$(date +"%Y-%m-%d %H:%M:%S.%3N")
   echo $current_datetime

   if ((attempt >= MAX_RETRY)); then
      echo "Max retry attempts exceeded: $attempt"

      return 1
   fi

   /bin/bash $GENERATE_SSL_SCRIPT
   status=$?

   echo "status: $status"

   if [ $status -eq 0 ]; then
      echo "Certificate generated, reload nginx"

      docker exec -it $NGINX_CONTAINER_NAME sh -c "nginx -s reload"

   else
      echo "Error occured during update ssl certificate"
      echo "Try out in $RETRY_TIMEOUT seconds"

      attempt=$((attempt + 1))

      sleep $RETRY_TIMEOUT
      execute
   fi
}

while :; do
   attempt=0

   execute

   sleep $TIMEOUT
done

