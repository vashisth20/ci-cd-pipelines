# Containerized Application Deployment with OIDC

This workflow builds a Docker image for a containerized application, pushes it to Azure Container Registry (ACR), and deploys it to an Azure Container App using OpenID Connect (OIDC) authentication.

## Prerequisites
1. **Azure Setup:**
   - Configure a federated identity in Azure for GitHub Actions OIDC.
   - Assign the `Contributor` and `AcrPush` roles to the identity.

2. **GitHub Secrets:**
   - Add the following secrets:
     - `AZURE_CLIENT_ID`: Application (client) ID.
     - `AZURE_TENANT_ID`: Azure AD Tenant ID.
     - `AZURE_SUBSCRIPTION_ID`: Azure subscription ID.
     - `ACR_NAME`: Azure Container Registry name.
     - `AZURE_RESOURCE_GROUP`: Resource group for the container app.

3. **GitHub Repository Permissions:**
   - Ensure the `id-token` permission is set to `write` in the workflow file.

## Steps
1. Push code to the `main` branch of your repository.
2. GitHub Actions will:
   - Authenticate with Azure using OIDC.
   - Build the Docker image.
   - Push it to ACR.
   - Update the Azure Container App to use the latest image.

## Notes
- Replace placeholder values in the workflow file with actual details.
- If needed, configure the app with environment variables or secrets using the Azure CLI.
