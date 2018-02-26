#!/bin/bash

$gitrepo = "https://github.com/USF-IT/Azure-Auto-deploy.git"
$token = "60c82331e070422159e9b62913788457f18ba20a"
$webappname = "USFTestCI"

# Create a resource group.
#az group create --location westeurope --name myResourceGroup  ---- USFTestCI

# Create an App Service plan in `FREE` tier.
#az appservice plan create --name $webappname --resource-group myResourceGroup --sku FREE

# Create a web app.
#az webapp create --name $webappname --resource-group myResourceGroup --plan $webappname

# Configure continuous deployment from GitHub. 
# --git-token parameter is required only once per Azure account (Azure remembers token).
az webapp deployment source config --name $webappname --resource-group USFTestCI --repo-url $gitrepo --branch master --git-token $token

# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net
# Testing .gitignore
