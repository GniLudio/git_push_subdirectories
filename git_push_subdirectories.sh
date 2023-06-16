#!/bin/bash

# Functions
function for_all_subdirs()
{
  local action_name="$1"
  local action=$2
  echo "$action_name"
  for subdir in `ls`
  do
    if [ -d "$subdir" ]
    then
      cd "$subdir"
      if [ -d ".git" ]
      then
        echo "    $subdir"
        $action &
      else
        echo "Skipping $subdir."
      fi
      cd ".."
    fi
  done
  wait
  echo "Done $action_name at `date`."
  echo
}
function git_fetch() {
  git fetch --quiet
}
function git_reset() {
  git reset --quiet --hard
}
function git_pull() {
  git pull --quiet
}
function git_add() {
  git add "$files_to_add" >/dev/null
}
function git_commit() {
  git commit -m "$commit_message" >/dev/null
}
function git_push() {
  git push --quiet
}

# Main
echo "Pushing all subdirectories in `pwd`/ at `date`:"
read -p "Files to add: " -e -i "default.txt" files_to_add
read -p "Commit message: " -e -i "Update XYZ" commit_message
echo

for_all_subdirs "Fetching" git_fetch
for_all_subdirs "Resetting" git_reset
for_all_subdirs "Pulling" git_pull
for_all_subdirs "Adding files" git_add
for_all_subdirs "Committing" git_commit
for_all_subdirs "Pushing" git_push

echo "Done all at `date`."
read -p "Press any key to close the terminal." -n 1
