
#!/bin/bash
Function categorize_files_modified {
[cmdletbinding()]
$Files = New-Object System.Collections.ArrayList;
$Files_Modified = New-Object System.Collections.ArrayList;
$Files_Added = New-Object System.Collections.ArrayList;
$Files_Deleted = New-Object System.Collections.ArrayList;

$Files = git diff master dev-branch --name-only

#git checkout master   ----- This script should be included in checkout function.
$Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure -Depth 30

git checkout dev-branch
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure -Depth 30

git checkout master

foreach($file in $Files)
{
foreach ($Masterfile in $Files_in_Master)
{
if (Test-Path $Masterfile -include $file)
		{
			$x=1
# File exists

			break
		}
		else
		{
			$x=0
# File doesn't exists.

		}

}
foreach ($Devfile in $Files_in_dev)
{
if (Test-Path $Devfile -include $file)
		{
			$y=1
# File exists

			break
		}
		else
		{
			$y=0
# File doesn't exists.

		}

}
if ($x -eq 1){

echo "$file is present in master branch"

}
else{

echo "$file is not present in master branch"

}
if ($y -eq 1){

echo "$file is present in dev branch"

}
else{

echo "$file is not present in dev branch"

}

}

echo $Files
}

categorize_files_modified

###################################################################################################################################################################################################################################
# Function categorize_files_deleted {
# [cmdletbinding()]
# Param (
# [string]$Name, 
# [int]$Hits, 
# [int]$AtBats
   # ) 
# # End of Parameters
# Process {

# if($Avg -gt 1) 
      # {

      # } # End of If
# Else {

         # } # End of Else.
      # } # End of Process
# }

# Function categorize_files_added {
# [cmdletbinding()]
# Param (
# [string]$Name, 
# [int]$Hits, 
# [int]$AtBats
   # ) 
# # End of Parameters
# Process {

# if($Avg -gt 1) 
      # {

      # } # End of If
# Else {

         # } # End of Else.
      # } # End of Process
# }