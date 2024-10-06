#!/bin/bash

git config user.name "CI Pipeline"
git config user.email "cipipeline@example.com" 

version=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

if [ $(git tag -l "$version") ]; then
    echo "Tag $version já existe. Adicionando alterações no CHANGELOG.md ..."
else
    echo "Tag $version não exite. Criando tag e adicionando notas de alterações no CHANGELOG.md ..."
    # cd config-repo-base-autochangelog
    git tag "$version"
    # git push  --tags 
    # git tag -l
    # ls -la
    # chmod +x note-releases.sh
    # ./note-releases.sh > CHANGELOG.md
fi