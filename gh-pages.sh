#!/bin/bash

# Define the name of the new branch
NEW_BRANCH="new-branch8"

echo "Branch $NEW_BRANCH already exists, checking it out and resetting it."
git checkout $NEW_BRANCH
git reset --hard HEAD
find . -mindepth 1 -not -path "./build*" -not -path "./.git*" -not -name ".env" -exec rm -rf {} + 2>/dev/null \
&& (mv build/* build/.* . 2>/dev/null || true) \
&& rmdir build 2>/dev/null


sleep 2

# for some reason i have todo it twice

find . -mindepth 1 -not -path "./build*" -not -path "./.git*" -not -name ".env" -exec rm -rf {} + 2>/dev/null \
&& (mv build/* build/.* . 2>/dev/null || true) \
&& rmdir build 2>/dev/null
# Add changes to the new branch
git add .

# Commit the changes
git commit -m "Replace all contents with build folder contents except .env"

# Optionally, push the new branch to the remote repository
# git push origin $NEW_BRANCH
