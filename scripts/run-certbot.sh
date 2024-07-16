#!/bin/bash
CERT_FILE="/etc/letsencrypt/live/certfolder/fullchain.pem"

generate() {
   certbot certonly \
   --standalone \
   -d $DOMAIN_URL \
   --cert-name=certfolder \
   --key-type rsa \
   --agree-tos \
   --noninteractive \
   --register-unsafely-without-email
}

renew() {
   certbot renew --force-renewal --noninteractive
}


if [ -e $CERT_FILE ]
then
   echo 'Certificates detected. Start Renewing'

   renew
else
   echo 'No certificates detected. Generate new one'

   generate
fi