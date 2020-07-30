#!/bin/bash
. ./docker.env
if [ $# -ne 1 ]
then
    echo "Syntax: $ program build_version"
    exit
fi

VERSION=$1
sh make_docker.sh
if [ $? -ne 0 ];
then
  echo "ERROR: Making docker failed...can not deploy, please fix";
  exit
fi

sudo docker tag $DOCKER_LOCAL_NAME:latest $DOCKER_URI:$VERSION
echo "Uploading Docker to ECS..."
sudo docker push $DOCKER_URI:$VERSION
echo -n "Done.."
