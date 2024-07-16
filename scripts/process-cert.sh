#!/bin/bash

CERT_FILE='.certbot/live/certfolder/fullchain.pem'
KEY_FILE='.certbot/live/certfolder/privkey.pem'

# certbot-gen or certbot-renew
CERTBOT_CONTAINER='certbot-gen'

log_datetime() {
   current_datetime=$(date +"%Y-%m-%d %H:%M:%S.%3N")
   echo $current_datetime
}

get_file_hash() {
   sha256sum "$1" | awk '{ print $1 }'
}

copy_certs_to_nginx() {
   cat $CERT_FILE > ".nginx/cert.pem"
   cat $KEY_FILE > ".nginx/key.pem"
}

echo "Start generate certificate"
log_datetime

initial_hash=$(get_file_hash "$CERT_FILE")

docker compose up $CERTBOT_CONTAINER

new_hash=$(get_file_hash "$CERT_FILE")

if [ "$initial_hash" != "$new_hash" ]
then
   echo "Certificate has been updated. Reloading NGINX..."
   copy_certs_to_nginx
   docker exec -it nginx nginx -s reload
else
   echo "No certificates has been generated"
fi