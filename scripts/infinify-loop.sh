#!/bin/bash

# TODO: remove
INTERVAL=60

# 12 hours
# INTERVAL=43200
SCRIPT="scripts/renew-cert.sh"

while true; do
   bash $SCRIPT

   sleep $INTERVAL
done