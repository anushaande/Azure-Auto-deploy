#!/bin/bash


# Function Find_in_dev 
# {
# [cmdletbinding()]
# Param ($file, [string[]]$array) 
# write-host "This is from dev function.File sent into dev function is $file `n" -ForegroundColor "Cyan"
# echo "array is $array"
# }





Function categorize_files_modified {
$Files = New-Object System.Collections.ArrayList;
$Files_in_dev = New-Object System.Collections.ArrayList;
$Files = git diff master dev-branch --name-only
git checkout master
$Files_in_dev = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Azure-Auto-deploy -Depth 1 -name
#$Files_in_dev = "Anusha", "Siva", "Nitesh" , "Andrew" , "Farzana"
foreach($file in $Files)
{
$m = Find_in_dev $file $Files_in_dev
echo "m is $m"
}
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

categorize_files_modified

# #$d = Find_in_dev $file_string,$Files_in_dev

##############################################################################################################################################################################################################################################
##############################################################################################################################################################################################################################################

# function printstuff
# {
   # param($v1, $v2, [string[]]$arr)
    # write-host 'write: $arr'
   # Foreach($s in $arr)
   # {
   # write-host $s
   # }
   # write-host 'write: $V1'
   # write-host $V1
   # write-host 'write: $V2'
   # write-host $v2
# }


# function checkprintstuff {
# $a = "A"
# $b = "b"
# $array = "AA , BB , CC"
# $i = 1,2,3

# foreach ($value in $i){

# printstuff $a $b $array
# printstuff ($a,$b,$array)

# }

# }

# checkprintstuff


































