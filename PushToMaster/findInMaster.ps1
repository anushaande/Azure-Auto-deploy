#!/bin/bash

Function categorize_files_modified_master {
$Files = New-Object System.Collections.ArrayList;
$Files_in_Master = New-Object System.Collections.ArrayList;
$Files = git diff master dev-branch --name-only
$Files_in_Master = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 2 -name
$Files_Status = @{}

foreach($file in $Files)
{

$index = $file.split("/").count 

$sfile = $file.split("/")[$index-1]

#echo "file name is $sfile `n"

$m = Find_in_Master $sfile $Files_in_Master
#echo "m is $m `n"
$Files_Status.Add($sfile, $m)
}
echo $Files_Status
}


Function Find_in_Master
{
[cmdletbinding()]
Param ($file, [string[]]$Files_in_Master ) 
# End of Parameters
write-host "This is from dev function.File sent into dev function is $file `n" -ForegroundColor "Cyan"
#echo "Array is $Files_in_dev `n"
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
#echo "Value of y in dev function is $y `n"
echo $x
}



































