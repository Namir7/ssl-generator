#!/bin/bash
CERT_FILE="/etc/letsencrypt/live/certfolder/fullchain.pem"

generate() {   
   certbot certonly \
   -d $DOMAIN_URL \
   --standalone \
   --cert-name=certfolder \
   --key-type rsa \
   --agree-tos \
   --noninteractive \
   --register-unsafely-without-email \
   # safe: --staging --break-my-certs
   --staging --break-my-certs
}

renew() {
   # safe: --staging --break-my-certs
   certbot renew --force-renewal --noninteractive --staging --break-my-certs
}


if [ -e $CERT_FILE ]
then
   echo 'Certificates detected. Start Renewing'

   renew
else
   echo 'No certificates detected. Generate new one'

   generate
fi