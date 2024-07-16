#!/bin/bash

sudo ls -la /etc/letsencrypt

certbot certonly --standalone --email $DOMAIN_EMAIL -d $DOMAIN_URL --cert-name=certfolder --key-type rsa --agree-tos --dry-run