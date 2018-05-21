#!/bin/bash

Function categorize_files_modified_dev {
$Files = New-Object System.Collections.ArrayList;
$Files_in_dev = New-Object System.Collections.ArrayList;
$Files = git diff master dev-branch --name-only
$Files_Status_dev = @{}
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 2 -name
#$Files_in_dev = "Anusha", "Siva", "Nitesh" , "Andrew" , "Farzana"
foreach($file in $Files)
{
$d = Find_in_dev $file $Files_in_dev
echo "d is $d"
$Files_Status_dev.Add($file, $d)
}
echo $Files_Status_dev
}

Function Find_in_dev 
{
[cmdletbinding()]
Param ($file, [string[]]$Files_in_dev ) 
# End of Parameters
write-host "This is from dev function.File sent into dev function is $file `n" -ForegroundColor "Cyan"
#echo "Array is $Files_in_dev `n"
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

categorize_files_modified_dev