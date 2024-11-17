# Automating OIDC Setup for GitHub Actions in Azure

This guide explains how to use a shell script to automate the setup of **OpenID Connect (OIDC)** for GitHub Actions, enabling secure and seamless authentication with Azure without the need for service principal secrets.

## Prerequisites
- **Azure CLI** installed and logged in to your Azure account.
- **GitHub Repository** where you plan to enable OIDC integration.
- **GitHub Organization** and Repository names.
- **Azure Subscription ID**, **Resource Group**, and **Azure Container Registry (ACR)** names.

## Running the OIDC Setup Script

### Step 1: Clone this Repository
If you haven't already, clone this repository to your local machine.

```bash
git clone https://github.com/vashisth20/ci-cd-pipelines.git
cd ci-cd-pipelines
```

### Step 2: Update the Script with Your Azure Details
Before running the script, update the following variables in setup-oidc.sh with your specific Azure and GitHub details:

- `SUBSCRIPTION_ID`: Your Azure subscription ID.
- `RESOURCE_GROUP`: Your Azure resource group.
- `ACR_NAME`: Your Azure Container Registry name.
- `GH_ORG`: Your GitHub organization name.
- `GH_REPO`: Your GitHub repository name.

### Step 3: Run the Script
Make the script executable and run it:

```bash
chmod +x setup-oidc.sh
./setup-oidc.sh
```

This script will:

- Create a new Azure Active Directory application for GitHub Actions OIDC.
- Set up a federated credential between GitHub and Azure.
- Assign the required roles (`Contributor` and `AcrPush`) to the application.

### Step 4: Verify the Configuration
Once the script completes successfully, you should be able to authenticate GitHub Actions to Azure using OIDC without requiring any service principal secrets. Check your Azure Active Directory for the new app and federated credentials.

### Troubleshooting
- **Azure CLI Errors:** Ensure that you are logged in to the correct Azure account and that you have sufficient permissions.
- **Missing Roles:** If role assignment fails, ensure that your Azure user has the required permissions to assign roles to the app.