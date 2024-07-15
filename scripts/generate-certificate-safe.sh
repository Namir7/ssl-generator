#!/bin/bash

BACKUP_DIR="/backups"

rm -rf /etc/letsencrypt/live/certs*

certbot certonly --standalone --dry-run --email $DOMAIN_EMAIL -d $DOMAIN_URL --cert-name=certfolder --key-type rsa --agree-tos
# certbot renew --cert-name=certs

certbot certonly -d $DOMAIN_URL --force-renewal --cert-name=certfolder --standalone

if [ $? -eq 0 ]; then
   timestamp=$(date +%s)
   curr_backup_dir="$BACKUP_DIR/$timestamp"

   mkdir $curr_backup_dir

   mv /etc/nginx/cert.pem "$curr_backup_dir/cert.pem"
   mv /etc/nginx/key.pem "$curr_backup_dir/key.pem"

   cp /etc/letsencrypt/live/certs*/fullchain.pem /etc/nginx/cert.pem
   cp /etc/letsencrypt/live/certs*/privkey.pem /etc/nginx/key.pem

else
   exit 1
fi
