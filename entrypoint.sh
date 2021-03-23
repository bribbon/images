#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Display noDejs version on dockerstart
echo " "
echo -e "Node: \033[46mnode -v\033[0m"
echo " "

# Run the Server
eval ${MODIFIED_STARTUP}