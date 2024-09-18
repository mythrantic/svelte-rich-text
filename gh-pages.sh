#!/bin/bash

# Define the name of the new branch
NEW_BRANCH="new-branch"

# Create and switch to the new branch
git checkout -b $NEW_BRANCH

# Perform the operations on the new branch
# Exclude the .git directory and .env file from deletion 
find . -mindepth 1 -not -path "./build*" -not -path "./.git*" -not -name ".env" -exec rm -rf {} + 2>/dev/null

# Check if the build directory exists and has contents
if [ -d "build" ]; then
  echo "Moving contents from build/ folder..."

  # Move all files and folders (including hidden files) from build to root
  shopt -s dotglob nullglob  # Enable globbing for hidden files and prevent errors if build is empty
  mv build/* . 2>/dev/null

  # Remove build directory if it's empty
  rmdir build 2>/dev/null
else
  echo "Build directory not found or is empty"
fi

# Add changes to the new branch
git add .

# Commit the changes
git commit -m "Replace all contents with build folder contents except .env"

# Optionally, push the new branch to the remote repository
# git push origin $NEW_BRANCH
