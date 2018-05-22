#!/bin/bash

Function categorize_files {
$Files = New-Object System.Collections.ArrayList;
$Files_in_branch = New-Object System.Collections.ArrayList;
$Files = git diff master dev-branch --name-only
$Files_in_branch = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 3 -name
$Files_Status_branch = @{}

foreach($file in $Files)
{
$status = Find_in_branch $file $Files_in_branch

$Files_Status_branch.Add($file, $status)
}
echo $Files_Status_branch
}

Function Find_in_branch 
{
[cmdletbinding()]
Param ($file, [string[]]$Files_in_branch ) 
# End of Parameters
write-host "This is from function.File sent into unction is $file `n" -ForegroundColor "Cyan"
#echo "Array is $Files_in_dev `n"
foreach($Branchfile in $Files_in_branch)
{
if (Test-Path $Branchfile -include $file)
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

