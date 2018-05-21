#!/bin/bash

."C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\PushToMaster\findInMaster.ps1"

$Files_Modified = New-Object System.Collections.ArrayList;
$Files_Added = New-Object System.Collections.ArrayList;
$Files_Deleted = New-Object System.Collections.ArrayList;
$Master_hash = [ordered]@{}
$Dev_hash = [ordered]@{}

git checkout master
$Master_hash = categorize_files_modified_master
echo "This is the hash table from master branch `n"
echo "-------------------------------------------- `n"
echo $Master_hash
git checkout dev-branch
$Dev_hash = categorize_files_modified_master
echo "This is the hash table from dev branch `n"
echo "-------------------------------------------- `n"
echo $Dev_hash


$files = $Master_hash.keys

foreach($file in $files){
$m = $Master_hash[$file]
$d = $Dev_hash[$file]

if     (($m -eq 1) -and ($d -eq 0))
{
$Files_Deleted.Add($file)
}
elseif (($m -eq 0) -and ($d -eq 1))
{
$Files_Added.Add($file)
}
elseif (($m -eq 1) -and ($d -eq 1))
{
$Files_Modified.Add($file)
}
}

echo "files added to dev branch are $Files_Added `n"
echo "Files deleted from dev branch are $Files_Deleted `n"
echo "Files that are just modified are $Files_Modified `n"

















































# Function categorize_files_modified {
# $Files = New-Object System.Collections.ArrayList;
# $Files_in_Master = New-Object System.Collections.ArrayList;
# $Files_in_dev = New-Object System.Collections.ArrayList;
# $Files = git diff master dev-branch --name-only

# git checkout master   #----- This script should be included in checkout function.
# $Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1 -name
# echo $Files_in_Master > ../master.txt
# git checkout dev-branch
# $Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1 -name
# echo $Files_in_dev > ../dev.txt
# #git checkout master

# foreach($file in $Files)
# {
# write-host "File sent into master function is $file `n" -ForegroundColor "Cyan"

# $m = Find_in_master $file $Files_in_Master
# echo "m = $m `n"

# write-host "File sent into dev function is $file `n" -ForegroundColor "Cyan"

# $d = Find_in_dev $file $Files_in_dev
# echo "d = $d `n"

# if     (($m -eq 1) -and ($d -eq 0))
# {
# echo "$file is present in master but not in dev branch `n"
# }
# elseif (($m -eq 0) -and ($d -eq 1))
# {
# echo "$file is not present in master but in dev branch `n"
# }
# elseif (($m -eq 1) -and ($d -eq 1))
# {
# echo "$file is present in both master as well as dev branch `n"
# }
# else
# {
# echo "$file is not present in master or dev branches `n"
# }
# }
# }



# Function Find_in_master 
# {
# [cmdletbinding()]
# Param ($file,  [string[]]$Files_in_Master) 
# # End of Parameters
# write-host "This is from master function.File sent into master function is $file `n" -ForegroundColor "Cyan"
# foreach($Masterfile in $Files_in_Master)
# {
# if (Test-Path $Masterfile -include $file)
# {
# $x = 1
# # echo "$file exists in master"
# break
# }
# else
# {
# $x = 0
# # echo "$file doesnot exist in master"
# }
# }
# #echo "Value of x in master function is $x `n"
# echo $x
# }

# Function Find_in_dev 
# {
# [cmdletbinding()]
# Param ($file, [string[]]$Files_in_dev) 
# # End of Parameters
# write-host "This is from dev function.File sent into dev function is $Devfile `n" -ForegroundColor "Cyan"
# foreach($Devfile in $Files_in_dev)
# {
# if (Test-Path $Devfile -include $file)
# {
# $y = 1
# # echo "$file exists in master"
# break
# }
# else
# {
# $y = 0
# # echo "$file doesnot exist in master"
# }
# }
# #echo "Value of y in dev function is $y `n"
# echo $y
# }



# categorize_files_modified

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



# $Files = New-Object System.Collections.ArrayList;


# $Files = git diff master dev-branch --name-only

# git checkout master   #----- This script should be included in checkout function.
# $Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
# echo $Files_in_Master > ../master.txt
# git checkout dev-branch
# $Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
# echo $Files_in_dev > ../dev.txt

# $Files_Modified = New-Object System.Collections.ArrayList;
# $Files_Added = New-Object System.Collections.ArrayList;
# $Files_Deleted = New-Object System.Collections.ArrayList;