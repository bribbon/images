#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Display noDejs version on dockerstart
echo " "
echo "Node:$ -e "node -v" installed"
node -v
echo " "

# Run the Server
eval ${MODIFIED_STARTUP}