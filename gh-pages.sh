#!/bin/bash

# Define the name of the new branch
NEW_BRANCH="new-branch2"

# Check if the branch already exists
if git rev-parse --verify $NEW_BRANCH >/dev/null 2>&1; then
  echo "Branch $NEW_BRANCH already exists, checking it out and resetting it."
  git checkout $NEW_BRANCH
  git reset --hard HEAD
else
  # Create and switch to the new branch
  echo "Creating new branch $NEW_BRANCH."
  git checkout -b $NEW_BRANCH
fi

# Stash any uncommitted changes before resetting
echo "Stashing uncommitted changes..."
git stash push -m "Stashing changes before resetting branch"

# Reset the new branch to match the state of the original branch
echo "Resetting branch to match the state of the original branch..."
git reset --hard HEAD

# Apply the stashed changes
echo "Applying stashed changes..."
git stash pop

# Change to the project root directory
PROJECT_ROOT="$(pwd)"
cd "$PROJECT_ROOT"

# Run npm install and build
if [ -f "package.json" ]; then
  echo "Running npm install..."
  npm install

  # Check if the build directory exists
  if [ ! -d "build" ]; then
    echo "Build directory not found. Running build command..."
    npm run build
  fi
else
  echo "package.json not found in the current directory. Exiting."
  exit 1
fi

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
