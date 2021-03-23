#!/bin/bash
cd /home/container
# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"
# display nodejs version on dockerstart

node -v

# Run the Server
eval ${MODIFIED_STARTUP}