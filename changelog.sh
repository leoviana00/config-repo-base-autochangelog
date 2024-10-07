#!/bin/bash

# Get the tag name from user input
# tag_name=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")
tag_name=0.0.1

# Verify that the tag exists
tag_exists=$(git tag -l "$tag_name")

if [ -z "$tag_exists" ]; then
  echo "Tag $tag_name does not exist!"
  exit 1
fi

# Force update the tag
git tag -f "$tag_name"

# Push the tag to the remote repository
git push -f origin "$tag_name"

echo "Tag $tag_name has been force updated!"
