#!/bin/bash

tag=$(cat tag.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

echo "Estou dentro do repositório?"
ls -la
sleep 3

echo "Existe alguma tag?"
git tag -l $tag | tac
sleep 5

for THIS_TAG in "$tag"; do
    git tag -l "$THIS_TAG"

    if [ $(git tag -l "$THIS_TAG") ]; then
        echo "Tag $THIS_TAG já existe. Adicionando alterações no CHANGELOG.md ..."
    else
        echo "Tag $THIS_TAG não existe. Criando tag e adicionando notas de alterações no CHANGELOG.md ..."
    fi

done