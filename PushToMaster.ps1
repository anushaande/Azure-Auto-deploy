#!/bin/bash
write-host "--------------------------------------Adding changes in dev-branch to master branch-----------------------------------------" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"
write-host "----------------------------------CHecking out to master------------------------------------------------" -ForegroundColor "Cyan"
git checkout master
write-host "----------------------------------Deleting the previous patch if any------------------------------------------------" -ForegroundColor "Cyan"
rm PatchOfDiff -Recurse -ErrorAction SilentlyContinue
write-host "----------------------------------Check differences between dev and master branch------------------------------------------------" -ForegroundColor "Cyan"
git diff master dev-branch > PatchOfDiff
write-host "----------------------------------Applying patch in master------------------------------------------------" -ForegroundColor "Cyan"
cat PatchOfDiff | git apply --reject --ignore-whitespace --whitespace=nowarn
write-host "----------------------------------Removing the patch which is applied------------------------------------------------" -ForegroundColor "Cyan"
rm PatchOfDiff
git add .
write-host "----------------------------------Commiting the changes in master branch------------------------------------------------" -ForegroundColor "Cyan"
$date = Date
git commit -m "Commiting changes on $date"
write-host "----------------------------------Pushing changes to master branch------------------------------------------------" -ForegroundColor "Cyan"
git push -u origin master 
rm .\.git\rebase-apply -Recurse -ErrorAction SilentlyContinue
write-host "----------------------------------Skipping the last patch if any errors------------------------------------------------" -ForegroundColor "Cyan"
git am --skip
write-host "----------------------------------Checking for git status------------------------------------------------" -ForegroundColor "Cyan"
git status
write-host "----------------------------------Checking for differences between master and dev-branch now-------------------------" -ForegroundColor "Cyan"
git diff master dev-branch
