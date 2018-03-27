#!/bin/bash


$list = "Gitpush.ps1","Additional.html"

$Files_in_CD = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure -Depth 2 
#Gitpush.ps1
#Additional.html

foreach ($listitem in $list)
{
echo "Started executing first foreach loop with selected file" $listitem
:outer
foreach ($file in $Files_in_CD)
{
echo "Started executing second Foreach loop and testing" $file 

if (Test-Path $file -include $listitem)
		{
			echo "This is from if in foreach loop" $listitem
			$x="True"
			break
		}
		else
		{
		    echo "This is from else in foreach" $listitem
			$x="False"
		}

}
echo $x
}
# If ($Selected_file.Exists) {Copy-Item $Selected_file LAN_Drive:\}
# Else {Write-Host "File does not exist"}


# foreach($scriptitem in $Script:x)
# {
# $item = $scriptitem | out-string
# echo "Started executing first foreach loop with selected file" $scriptitem
# :outer
# foreach ($file in $Files_in_CD)
# {
# echo "Started executing second Foreach loop and testing" $file 

# if (Test-Path $file -include $item)
		# {
		   # echo "This is from if in foreach loop" $item
			# $x="True"
			# break
		# }
		# else
		# {
		  # echo "This is from else in foreach" $item
			# $x="False"
		# }

# }
# echo $x
# }
