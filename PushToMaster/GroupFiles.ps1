#!/bin/bash

."C:\WorkStation\PowerShell\PushToMaster\PushToMaster\Scripts\findInBranch.ps1"

$Files_Modified = New-Object System.Collections.ArrayList;
$Files_Added = New-Object System.Collections.ArrayList;
$Files_Deleted = New-Object System.Collections.ArrayList;
$Master_hash = [ordered]@{}
$Dev_hash = [ordered]@{}

cd C:\WorkStation\GitLocalRepo\Azure-Auto-deploy
git checkout master
$Master_hash = categorize_files
echo "This is the hash table from master branch `n"
echo "-------------------------------------------- `n"
echo $Master_hash
git checkout dev-branch
$Dev_hash = categorize_files
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

echo "files added to dev branch are `n"
echo "$Files_Added `n"
echo "Files deleted from dev branch are 'n"
echo "$Files_Deleted `n"
echo "Files that are just modified are 'n"
echo "$Files_Modified `n"

cd C:\WorkStation\PowerShell\PushToMaster\PushToMaster\Scripts

