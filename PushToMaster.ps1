#!/bin/bash
write-host "--------------------------------------Adding changes in dev-branch to master branch-----------------------------------------" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
write-host "----------------------------------Checking to master-------------------------------------------------------" -ForegroundColor "Cyan"
git checkout master
rm PatchOfDiff -Recurse -ErrorAction SilentlyContinue
git diff master dev-branch > PatchOfDiff
write-host "----------------------------------Applying changes in dev-branch to master---------------------------------" -ForegroundColor "Cyan"
cat PatchOfDiff | git apply --reject --ignore-whitespace --whitespace=nowarn
rm PatchOfDiff
git add .
write-host "----------------------------------Committing the changes in master branch----------------------------------" -ForegroundColor "Cyan"
$date = Date
git commit -m "Committing changes on $date"
write-host "----------------------------------Pushing changes to master branch-----------------------------------------" -ForegroundColor "Cyan"
git push -u origin master 
rm .\.git\rebase-apply -Recurse -ErrorAction SilentlyContinue
git am --skip
write-host "----------------------------------Git status---------------------------------------------------------------" -ForegroundColor "Cyan"
git status
write-host "----------------------------------Going back to "dev-branch"-----------------------------------------------" -ForegroundColor "Cyan"
git checkout dev-branch