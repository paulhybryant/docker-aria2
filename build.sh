#!/bin/bash

# npm install -g dockerfile-include
dockerfile-include -i docker.build -o Dockerfile
if [[ "${OSTYPE}" == *darwin* ]]; then
  docker build .
else
  sudo docker build .
fi
