#!/bin/bash

LOGS_FILE='../.logs/certbot.log'
CERT_FILE='/etc/letsencrypt/live/certfolder/fullchain.pem'
KEY_FILE='/etc/letsencrypt/live/certfolder/privkey.pem'

NGINX_CONTAINER='nginx'
NGINX_FOLDER='nginx'

log_datetime() {
   current_datetime=$(date +"%Y-%m-%d %H:%M:%S.%3N")
   echo $current_datetime
}

get_file_hash() {
   sha256sum "$1" | awk '{ print $1 }'
}

copy_certs_to_nginx() {
   cat $CERT_FILE > "$NGINX_FOLDER/cert.pem"
   cat $KEY_FILE > "$NGINX_FOLDER/key.pem"
}

echo "Start generate certificate"
log_datetime

initial_hash=$(get_file_hash "$CERT_FILE")

certbot renew --force-renewal --dry-run

new_hash=$(get_file_hash "$CERT_FILE")

if [ "$initial_hash" != "$new_hash" ]
then
   echo "Certificate has been updated. Reloading NGINX..."
   copy_certs_to_nginx
   docker exec "$NGINX_CONTAINER" nginx -s reload
else
   echo "No certificates has been generated"
fi