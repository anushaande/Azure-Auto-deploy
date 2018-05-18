#!/bin/bash

$files = ".gitignore", "createfolders.ps1", "exp.ps1", "link1.html", "link6.html" , "newfile.txt", "PushToMaster.ps1" 
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1

foreach($file in $files)
{
foreach($Devfile in $Files_in_dev)
{
if (Test-Path $Devfile -include $file)
{
$x = 1
echo "$file exists in master"
break
}
else
{
$x = 0
echo "$file doesnot exist in master"
}
}
}

