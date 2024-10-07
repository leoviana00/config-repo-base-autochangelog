#!/bin/bash

version=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

if [ $(git tag -l "$version") ]; then
    echo "Tag $version já existe. Adicionando alterações no CHANGELOG.md ..."
else
    echo "Tag $version não existe. Criando tag e adicionando notas de alterações no CHANGELOG.md ..."
fi

