#!/bin/bash

# Description:
# This script automates the process of configuring Azure Federated Identity 
# for GitHub Actions OIDC authentication and assigns the necessary roles.

# Replace these variables with your Azure details
SUBSCRIPTION_ID="<Your Azure Subscription ID>"
RESOURCE_GROUP="<Your Resource Group>"
ACR_NAME="<Your Azure Container Registry Name>"
APP_NAME="GitHubActionsOIDC"  # Name for the Azure App used for OIDC
GH_ORG="<Your GitHub Org>"
GH_REPO="<Your GitHub Repo>"

# Create an Azure Active Directory Application (App) for OIDC authentication
echo "Creating Azure AD Application for GitHub OIDC authentication..."
APP_ID=$(az ad app create --display-name $APP_NAME --query "appId" -o tsv)

if [ -z "$APP_ID" ]; then
    echo "Failed to create Azure AD App. Exiting..."
    exit 1
fi
echo "Azure AD Application created with App ID: $APP_ID"

# Create the federated credential (OIDC)
echo "Creating Federated Credential (OIDC)..."
az ad app federated-credential create --id $APP_ID --parameters '{
  "name": "GitHubActionsOIDC",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:'$GH_ORG'/'$GH_REPO':ref:refs/heads/main",
  "description": "GitHub Actions OIDC for Azure"
}'

echo "Federated credential created successfully!"

# Assign required roles to the Azure AD App
echo "Assigning roles to the Azure AD App..."
az role assignment create --assignee $APP_ID --role Contributor --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP
az role assignment create --assignee $APP_ID --role AcrPush --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ContainerRegistry/registries/$ACR_NAME

if [ $? -eq 0 ]; then
    echo "Roles assigned successfully!"
else
    echo "Failed to assign roles. Exiting..."
    exit 1
fi

echo "OIDC setup completed successfully!"
