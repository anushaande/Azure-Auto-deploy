#!/bin/bash
write-host "--------------------------------------Adding changes in dev-branch to master branch-----------------------------------------" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"

git checkout dev-branch
rm PatchOfDiff -Recurse -ErrorAction SilentlyContinue
git diff dev-branch master > PatchOfDiff
cat PatchOfDiff | git apply --reject --ignore-whitespace --whitespace=nowarn
rm PatchOfDiff
$date = Date
git commit -m "Commiting changes on $date"
git push -u origin master 
rm .\.git\rebase-apply -Recurse -ErrorAction SilentlyContinue
git am --skip
git status

