#!/bin/bash


$Commited_list = New-Object System.Collections.ArrayList
# $Files_Committed = New-Object System.Collections.ArrayList
# $Files_Selected = New-Object System.Collections.ArrayList tgrcfd3he files changed in the most recent commit and convert them as an ArrayList
$Commited_list = git log --format="%H" --after="2018-4-1 11:00:00 AM" --before="Tuesday, May 1, 2018 3:03:38 PM"
#$Files_Committed = git diff-tree --no-commit-id --name-only -r $Commit_id | Format-list
$i=1
foreach($commit in $Commited_list)
{

echo "commit id $i is $commit"
$i = $i+1

}

