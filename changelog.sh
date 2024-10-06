#!/bin/bash

git config user.name "CI Pipeline"
git config user.email "cipipeline@example.com" 

version=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

if [ $(git tag -l "$version") ]; then
    echo "Tag $version já existe. Adicionando alterações no RELEASE_NOTES.md ..."
else
    echo "Tag $version não exite. Criando tag e adicionando notas de alterações no RELEASE_NOTES.md ..."
fi