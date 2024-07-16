#!/bin/bash

certbot certonly \
--standalone \
-d $DOMAIN_URL \
--cert-name=certfolder \
--key-type rsa \
--agree-tos \
--noninteractive \
--register-unsafely-without-email
