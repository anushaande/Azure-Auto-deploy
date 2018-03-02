#!/bin/bash
$resourceGroupName = "USFTestCI"
$webAppName = "USFTestCI"
function Get-AzureRmWebAppPublishingCredentials($resourceGroupName, $webAppName, $slotName = $null){

$resourceGroupName = "USFTestCI"
$webAppName = "USFTestCI"

	if ([string]::IsNullOrWhiteSpace($slotName)){
		$resourceType = "Microsoft.Web/sites/config"
		$resourceName = "$webAppName/publishingcredentials"
	}
	else{
		$resourceType = "Microsoft.Web/sites/slots/config"
		$resourceName = "$webAppName/$slotName/publishingcredentials"
	}
	$publishingCredentials = Invoke-AzureRmResourceAction -ResourceGroupName $resourceGroupName -ResourceType $resourceType -ResourceName $resourceName -Action list -ApiVersion 2015-08-01 -Force
    	return $publishingCredentials
}

function Get-KuduApiAuthorisationHeaderValue($resourceGroupName, $webAppName, $slotName = $null){

$resourceGroupName = "USFTestCI"
$webAppName = "USFTestCI"

    $publishingCredentials = Get-AzureRmWebAppPublishingCredentials $resourceGroupName $webAppName $slotName
    return ("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $publishingCredentials.Properties.PublishingUserName, $publishingCredentials.Properties.PublishingPassword))))
}


# function Download-FileFromWebApp($resourceGroupName, $webAppName, $slotName = "", $kuduPath, $localPath){

# $resourceGroupName = "USFTestCI"
# $webAppName = "USFTestCI"
# $kuduPath = "getPublichingCredentials.ps1"
# $localPath = "Documents"

    # $kuduApiAuthorisationToken = Get-KuduApiAuthorisationHeaderValue $resourceGroupName $webAppName $slotName
    # if ($slotName -eq ""){
        # $kuduApiUrl = "https://$webAppName.scm.azurewebsites.net/api/vfs/site/wwwroot/$kuduPath"
    # }
    # else{
        # $kuduApiUrl = "https://$webAppName`-$slotName.scm.azurewebsites.net/api/vfs/site/wwwroot/$kuduPath"
    # }
    # $virtualPath = $kuduApiUrl.Replace(".scm.azurewebsites.", ".azurewebsites.").Replace("/api/vfs/site/wwwroot", "")
    # Write-Host " Downloading File from WebApp. Source: '$virtualPath'. Target: '$localPath'..." -ForegroundColor DarkGray

    # Invoke-RestMethod -Uri $kuduApiUrl `
                        # -Headers @{"Authorization"=$kuduApiAuthorisationToken;"If-Match"="*"} `
                        # -Method GET `
                        # -OutFile $localPath `
                        # -ContentType "multipart/form-data"
# }

# Download-FileFromWebApp

function Download-FileFromWebApp($resourceGroupName, $webAppName, $slotName = "", $kuduPath){

$resourceGroupName = "USFTestCI"
$webAppName = "USFTestCI"
$kuduPath = "getPublichingCredentials.ps1~"

    $kuduApiAuthorisationToken = Get-KuduApiAuthorisationHeaderValue $resourceGroupName $webAppName $slotName
    if ($slotName -eq ""){
        $kuduApiUrl = "https://$webAppName.scm.azurewebsites.net/api/vfs/site/wwwroot/$kuduPath"
    }
    else{
        $kuduApiUrl = "https://$webAppName`-$slotName.scm.azurewebsites.net/api/vfs/site/wwwroot/$kuduPath"
    }
    $virtualPath = $kuduApiUrl.Replace(".scm.azurewebsites.", ".azurewebsites.").Replace("/api/vfs/site/wwwroot", "")
    #Write-Host " Downloading File from WebApp. Source: '$virtualPath'. Target: '$localPath'..." -ForegroundColor DarkGray
	Write-Host "Deleting the file '$KuduPath' at Target: '$kuduApiUrl'..." -ForegroundColor DarkGray
    Invoke-RestMethod -Uri $kuduApiUrl `
                        -Headers @{"Authorization"=$kuduApiAuthorisationToken;"If-Match"="*"} `
                        -Method DELETE `
						-ContentType "multipart/form-data"
                        
}

Download-FileFromWebApp





