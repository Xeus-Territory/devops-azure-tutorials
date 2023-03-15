#!/bin/bash

apt update
apt install docker-compose -y
apt install pass gnupg2 -y
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login --identity
az acr login --name devopsorient
# az storage blob download --auth-mode login --account-name devstoragedatacompose -c docker -n docker-compose.yaml > docker-compose.yaml
az storage blob download --auth-mode login --account-name ${bucketname} -c docker -n docker-compose.yaml > docker-compose.yaml
docker-compose up -d