$Files_Committed = New-Object System.Collections.ArrayList

# Get the files changed in the most recent commit and convert them as an ArrayList
$Commit_id = git log --format="%H" -n 1
$Files_Committed = git diff-tree --no-commit-id --name-only -r $Commit_id | Format-list

#Create a patch with commit id.
$id_to_String = $Commit_id | out-string
$Patch_id = "Patch" + $id_to_String.Trim() 
$Patch_name = $Patch_id + ".patch"
git format-patch -1 Head Additional.html --stdout > $Patch_name
