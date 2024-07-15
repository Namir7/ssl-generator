#!/bin/bash

rm -rf /etc/letsencrypt/live/certfolder*

certbot certonly --standalone --email $DOMAIN_EMAIL -d $DOMAIN_URL --cert-name=certfolder --key-type rsa --agree-tos

if [ -f /etc/letsencrypt/live/certfolder/fullchain.pem ] && [ -f /etc/letsencrypt/live/certfolder/privkey.pem ]; then
    rm -rf /etc/nginx/cert.pem
    rm -rf /etc/nginx/key.pem

    cp /etc/letsencrypt/live/certfolder/fullchain.pem /etc/nginx/cert.pem
    cp /etc/letsencrypt/live/certfolder/privkey.pem /etc/nginx/key.pem

    BACKUP_DIR=/etc/nginx/backup_$(date +%s)
    mkdir $BACKUP_DIR
    cp /etc/letsencrypt/live/certfolder/fullchain.pem /etc/nginx/$BACKUP_DIR/cert.pem
    cp /etc/letsencrypt/live/certfolder/privkey.pem /etc/nginx/$BACKUP_DIR/key.pem
else
    echo "Certificate files were not generated."
fi