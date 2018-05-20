#!/bin/bash
$Files = New-Object System.Collections.ArrayList;
$Files_Modified = New-Object System.Collections.ArrayList;
$Files_Added = New-Object System.Collections.ArrayList;
$Files_Deleted = New-Object System.Collections.ArrayList;

$Files = git diff master dev-branch --name-only

git checkout master   #----- This script should be included in checkout function.
$Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
echo $Files_in_Master > ../master.txt
git checkout dev-branch
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
echo $Files_in_dev > ../dev.txt

Function Find_in_master 
{
[cmdletbinding()]
Param (
[string]$file, 
[int]$x, 
$Files_in_Master
   ) 
# End of Parameters
echo "This is from master function . File sent into master function is $file"
foreach($Masterfile in $Files_in_Master)
{
if (Test-Path $Masterfile -include $file)
{
$x = 1
# echo "$file exists in master"
break
}
else
{
$x = 0
# echo "$file doesnot exist in master"
}
}
echo "Value of x in master function is $x"
# return $x
}

Function Find_in_dev 
{
[cmdletbinding()]
Param (
[string]$file, 
[int]$y, 
$Files_in_dev
   ) 
# End of Parameters
echo "This is from dev function . File sent into dev function is $file"
foreach($Devfile in $Files_in_dev)
{
if (Test-Path $Devfile -include $file)
{
$y = 1
# echo "$file exists in master"
break
}
else
{
$y = 0
# echo "$file doesnot exist in master"
}
}
echo "Value of y in dev function is $y"
# return $y
}

Function categorize_files_modified {
# $Files = New-Object System.Collections.ArrayList;
# $Files_Modified = New-Object System.Collections.ArrayList;
# $Files_Added = New-Object System.Collections.ArrayList;
# $Files_Deleted = New-Object System.Collections.ArrayList;

# $Files = git diff master dev-branch --name-only

# git checkout master   #----- This script should be included in checkout function.
# $Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
# echo $Files_in_Master > ../master.txt
# git checkout dev-branch
# $Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
# echo $Files_in_dev > ../dev.txt
#git checkout master

foreach($file in $Files)
{

echo "File sent into master function is $file"

$m = Find_in_master
echo "m = $m"

echo "File sent into dev function is $file"
$d = Find_in_dev
echo "d = $d"

if     (($m -eq 1) -and ($d -eq 0))
{
echo "$file is present in master but not in dev branch"
}
elseif (($m -eq 0) -and ($d -eq 1))
{
echo "$file is not present in master but in dev branch"
}
elseif (($m -eq 1) -and ($d -eq 1))
{
echo "$file is present in both master as well as dev branch"
}
else
{
echo "$file is not present in master or dev branches"
}
}
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