# # #!/bin/bash

# # $item = "link5.html"

# # $sourceItem = "C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\$item"

# # get-childitem $sourceItem | copy-item -Destination 'C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure'


# # echo "File is copied successfully"
# $Commit_id = "438a3e255187c6fd90ed6a2496d4037c9464aac"
# $Patch_id = "Patch" + $Commit_id.Trim()
# $Patch_name = $Patch_id + ".patch"
# echo $Patch_name
# echo $Patch_id

# #echo "Hello World!" > $Patch_name

# git format-patch -1 Head --stdout > $Patch_name

$Current_Directory = pwd
echo "You are in $Current_Directory"
set-location 'C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure' 
$Changed_location = pwd
echo "Your location is changed to $Changed_location"
set-location $Current_Directory
pwd
