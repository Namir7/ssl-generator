#!/bin/bash

# 12 hours
INTERVAL=43200

excutable="bash scripts/process-cert.sh"

while true; do
   echo 'Start interation'
   $executable

   sleep $INTERVAL
done