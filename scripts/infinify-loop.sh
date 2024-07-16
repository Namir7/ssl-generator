#!/bin/bash

# 12 hours
INTERVAL=43200
SCRIPT="scripts/process-cert.sh"

while true; do
   bash $SCRIPT

   sleep $INTERVAL
done