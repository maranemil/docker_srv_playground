#!/bin/bash

# clean docker containers and volumes
docker rm -f $(docker ps -aq)
docker container prune
docker volume rm $(docker volume ls -q)

# set local user as owner
CURRENT_DIR=$(basename "$PWD")
#sudo chown -R $USER:$USER $(pwd -P)
#sudo chown -R $USER:$USER $PWD
sudo chown -Rv "$USER":"$USER" ../"$CURRENT_DIR"
