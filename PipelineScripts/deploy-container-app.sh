#!/bin/bash

# Set environment variables (or use secrets in GitHub Actions)
ACR_NAME=$1
RESOURCE_GROUP=$2
CONTAINER_APP_NAME=$3
IMAGE_NAME=$4

# Check if the Azure Container App exists
az containerapp show --name $CONTAINER_APP_NAME --resource-group $RESOURCE_GROUP > /dev/null 2>&1

# Deploy or Create Azure Container App
if [ $? -eq 0 ]; then
  echo "Container App exists, updating..."
  az containerapp update \
    --name $CONTAINER_APP_NAME \
    --resource-group $RESOURCE_GROUP \
    --image $ACR_NAME.azurecr.io/$IMAGE_NAME:latest
else
  echo "Container App not found, creating..."
  az containerapp create \
    --name $CONTAINER_APP_NAME \
    --resource-group $RESOURCE_GROUP \
    --image $ACR_NAME.azurecr.io/$IMAGE_NAME:latest \
    --cpu 0.5 --memory 1.0Gi \
    --env-vars ENV_VAR_NAME=value
fi
