#!/bin/bash

Function categorize_files_modified {
$Files = New-Object System.Collections.ArrayList;
$Files = git diff master dev-branch --name-only
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1
foreach($file in $Files)
{
$file_string = $file | out-string
$d = Find_in_dev $file_string,$Files_in_dev
echo "d = $d `n"
}
}

Function Find_in_dev 
{
[cmdletbinding()]
Param (
$file,  
[string[]]$Files_in_dev
   ) 
# End of Parameters
#echo "This is from dev function.File sent into dev function is $file `n"
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
#echo "Value of y in dev function is $y `n"
echo $y
}

categorize_files_modified




