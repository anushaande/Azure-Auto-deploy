#!/bin/bash


$s = @("link6.html" , ".gitignore" , "exp.ps1" , "PushToMaster/findInMaster.ps1" , "newfile.txt" , "exp1.ps1" , "PushToMaster/findIndev.ps1" , "exp2.ps1" , "createfolders.ps1" , "link1.html" , "PushToMaster.ps1")

foreach ($path in $s){

$index = $path.split("/").count 

$file = $path.split("/")[$index-1]

echo "file in $path is $file"

}

# Name                           Value
# ----                           -----
# link6.html                     1
# .gitignore                     1
# exp.ps1                        1
# PushToMaster/findInMaster.ps1  0
# newfile.txt                    0
# exp1.ps1                       0
# PushToMaster/findIndev.ps1     0
# exp2.ps1                       1
# createfolders.ps1              1
# link1.html                     0
# PushToMaster.ps1               1
