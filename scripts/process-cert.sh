#!/bin/bash

CERT_FILE='.certbot/live/certfolder/fullchain.pem'

log_datetime() {
   current_datetime=$(date +"%Y-%m-%d %H:%M:%S.%3N")
   echo $current_datetime
}

get_file_hash() {
   sha256sum "$1" | awk '{ print $1 }'
}


echo "Start process certificate"
log_datetime

initial_hash=$(get_file_hash "$CERT_FILE")

docker compose up certbot

new_hash=$(get_file_hash "$CERT_FILE")

if [ "$initial_hash" != "$new_hash" ]
then
   echo "Certificate has been updated. Reloading NGINX..."
   docker exec -it nginx nginx -s reload
else
   echo "No certificates has been generated"
fi