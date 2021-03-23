#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# display nodejs version on dockerstart
\n
echo -e "Node: \033[46m${node -v}\033[0m"
\n

# Run the Server
eval ${MODIFIED_STARTUP}