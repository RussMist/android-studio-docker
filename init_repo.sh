#!/usr/bin/env bash

# Redefine for current project.
REPO_NAME="repo_name"
REPO_URL="repo_url"
REPO_SUBDIR="repo_subdir"
# end

git init $REPO_NAME
cd $REPO_NAME
git remote add origin $REPO_URL
git config core.sparsecheckout true
echo $REPO_SUBDIR >> .git/info/sparse-checkout
git pull --depth=1 origin master