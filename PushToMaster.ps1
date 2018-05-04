#!/bin/bash
write-host "--------------------------------------Adding changes in dev-branch to master branch-----------------------------------------" -ForegroundColor "Yellow" -BackgroundColor "DarkGreen"

git checkout master
rm PatchOfDiff -Recurse -ErrorAction SilentlyContinue
git diff master dev-branch > PatchOfDiff
cat PatchOfDiff | git apply --reject --ignore-whitespace --whitespace=nowarn
rm PatchOfDiff
git add .
$date = Date
git commit -m "Commiting changes on $date"
git push -u origin master 
rm .\.git\rebase-apply -Recurse -ErrorAction SilentlyContinue
git am --skip
git status

