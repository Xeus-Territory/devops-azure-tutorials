#!/bin/bash
az login --identity 
az acr login --name ${containerRegistry_main}
az storage blob download --auth-mode login --account-name ${storageAccount_web} -c ${storageContainer_web} -n ${storageBlob_web}  > docker-compose.yaml
docker-compose up -d