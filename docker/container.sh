#!/usr/bin/env bash

set -x
export DEBIAN_FRONTEND=noninteractive
# Absolute path to this repo
SCRIPT=$(readlink -f "$0")
export REPOPATH=$(dirname "$SCRIPT")/..

# what you can do
CLEAR=N
CLEANUP=N
BUILD=N
RUN=N

# you can also set the flags using the command line
for var in "$@"
do
	if [ "CLEAR" == "$var" ]; then CLEAR=Y 
	fi
	if [ "CLEANUP" == "$var" ]; then CLEANUP=Y 
	fi
	if [ "BUILD" == "$var" ]; then BUILD=Y 
	fi
	if [ "RUN" == "$var" ]; then RUN=Y 
	fi
done

# clean up all containers
if [ "${CLEAR}" == "Y" ]; then
	sudo docker stop WEBAPP
	sudo docker kill WEBAPP
	sudo docker rm -f WEBAPP
fi

# clean up all images
if [ "${CLEANUP}" == "Y" ]; then
	./$0 CLEAR
	sudo docker rmi -f apache
fi

# create imageS
if [ "${BUILD}" == "Y" ]; then
	./$0 CLEAR
	./$0 CLEANUP
	sudo docker build --rm=true -t apache $REPOPATH/docker
fi

# run the container database in the background (including initial data load
if [ "${RUN}" == "Y" ]; then
	./$0 CLEAR
	if [ "$(sudo docker images | grep apache)" == "" ]; then
		./$0 BUILD
	fi
	sudo docker run -d --name WEBAPP -p 80:80 -v $REPOPATH/src:/var/www/html apache 
fi

