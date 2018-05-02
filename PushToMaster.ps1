#!/bin/bash

write-host "--------------------------------------COMMITTING CHANGES TO CD-----------------------------------------" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"

$Files_Committed = New-Object System.Collections.ArrayList
$ToPatch = New-Object System.Collections.ArrayList
$ToCopy = New-Object System.Collections.ArrayList
$Commit_id = git log --format="%H" -n 1
$Files_Committed = git diff-tree --no-commit-id --name-only -r $Commit_id | Format-list
$id_to_String = $Commit_id | out-string
$Patch_id = "Patch" + $id_to_String.Trim() 
$Patch_name = $Patch_id + ".patch"
$Script:x = @()
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$objForm = New-Object System.Windows.Forms.Form 
$objForm.Text = "Data Entry Form"
$objForm.Size = New-Object System.Drawing.Size(1000,600) 
$objForm.StartPosition = "CenterScreen"
$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter"){
        foreach ($objItem in $objListbox.SelectedItems)
            {$Script:x += $objItem}
        $objForm.Close()
    }
    })
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape"){
$objForm.Close()
	}})
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click(
   {
        foreach ($objItem in $objListbox.SelectedItems)
            {$Script:x += $objItem}
        $objForm.Close()
   })
$objForm.Controls.Add($OKButton)
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$objForm.Close()})
$objForm.Controls.Add($CancelButton)
$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(10,20) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.Text = "Please select the files to add to CD:"
$objForm.Controls.Add($objLabel) 
$objListbox = New-Object System.Windows.Forms.Listbox 
$objListbox.Location = New-Object System.Drawing.Size(10,40) 
$objListbox.Size = New-Object System.Drawing.Size(400,50) 
$objListbox.SelectionMode = "MultiExtended"
for ( $i = 0; $i -le $Files_Committed.length -1; $i++ ){

$ItemIs = $Files_Committed[$i] | out-string
[void] $objListbox.Items.Add($ItemIs)

}

$objListbox.Height = 70
$objForm.Controls.Add($objListbox) 
$objForm.Topmost = $True

$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()
if ($script:x.length -eq 0){

write-host "No Files are Selected to commit to CD .......... Please run the script again to select a file and proceed" -ForegroundColor "Magenta"
exit
}
else{
write-host "----------------------------------Files selected are------------------------------------------------" -ForegroundColor "Cyan"

$Script:x

write-host "----------------------------------------------------------------------------------------------------" -ForegroundColor "Cyan" 
}
write-host "----------------------------------Checking if the files selected already exists in CD Work Station--" -ForegroundColor "Cyan"
$Files_in_CD = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure -Depth 2 


foreach($scriptitem in $Script:x)
{
$item = $scriptitem | out-string
$Itemed = $item.trim()
:outer
foreach ($file in $Files_in_CD)
{
if (Test-Path $file -include $Itemed)
		{
			$x=1
			break
		}
		else
		{
			$x=0
			}

}
if ($x -eq 1){

write-host "$Itemed File exists in CD" 
[void] $ToPatch.Add($Itemed)

}
else{

write-host "$Itemed File doesn't exist"
$sourceItem = "C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\$Itemed"
get-childitem $sourceItem | copy-item -Destination 'C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure'
[void] $ToCopy.Add($Itemed)
}
}
echo "Items to copy list - $ToCopy"
git format-patch -1 Head $ToPatch --stdout > $Patch_name

write-host "----------------------------------------------------------------------------------------------------" -ForegroundColor "Cyan"
$source_patch = "C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\$Patch_name"
rm C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure\.git\rebase-apply -Recurse -ErrorAction SilentlyContinue
rm C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure\*.rej -Recurse -ErrorAction SilentlyContinue
set-location 'C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure'
write-host "----------------------------------Applying changes to CD--------------------------------------------" -ForegroundColor "Cyan"

cat $source_patch | git am --reject --ignore-whitespace --whitespace=nowarn

$Files_in_CD1 = Get-ChildItem -Path C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure -Depth 1

foreach ($file in $Files_in_CD1)
{
if (Test-Path $file -include *.rej){
			$y=1
			break
		}
		else
		{
			$y=0
			}	
}	
if ($y -eq 1){
write-host "Few files got rejected from applying patch. Please fix the issue as given in the error report above" -ForegroundColor "Red"
set-location 'C:\WorkStation\GitLocalRepo\Azure-Auto-deploy' 
cp C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\$Patch_name C:\WorkStation\GitLocalRepo\Sitecore-Auto-Deploy-To-Azure
rm C:\WorkStation\GitLocalRepo\Azure-Auto-deploy\$Patch_name
exit

}
	
else{
write-host  "Patch is applied successfully" -ForegroundColor "Green"
}	 
write-host "----------------------------------------------------------------------------------------------------" -ForegroundColor "Cyan"


write-host "----------------------------------Pushing changes to CD remote repository---------------------------" -ForegroundColor "Cyan"
git push -u origin master
set-location 'C:\WorkStation\GitLocalRepo\Azure-Auto-deploy' 
rm $source_patch
write-host "----------------------------------------------------------------------------------------------------" -ForegroundColor "Cyan"


	