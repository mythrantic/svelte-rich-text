#!/bin/bash

# Define the name of the new branch
NEW_BRANCH="new-branch"

# Create and switch to the new branch
git checkout -b $NEW_BRANCH

# Perform the operations on the new branch
# Exclude the .git directory and .env file from deletion 
find . -mindepth 1 -not -path "./build*" -not -path "./.git*" -not -name ".env" -exec rm -rf {} + 2>/dev/null

# Move files and hidden files from the build directory to the current directory
for file in build/.* build/*; do
  [ -e "$file" ] && mv "$file" . 2>/dev/null
done

# Remove the build directory if it is empty
rmdir build 2>/dev/null

# Add changes to the new branch
git add .

# Commit the changes
git commit -m "Replace all contents with build folder contents except .env"

# Optionally, push the new branch to the remote repository
# git push origin $NEW_BRANCH
