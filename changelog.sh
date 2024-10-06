#!/bin/bash

version=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

for THIS_TAG in "$version"; do

    git tag -l "$THIS_TAG"

    if [ $(git tag -l "$THIS_TAG | tac") ]; then
        echo "Tag $THIS_TAG já existe. Adicionando alterações no CHANGELOG.md ..."
        chmod +x note-releases.sh
        ./note-releases.sh > CHANGELOG.md
        git add CHANGELOG.md 
        git commit -m "docs(CHANGELOG): update release notes"
        git push origin HEAD:main
    else
        echo "Tag $THIS_TAG não existe. Criando tag e adicionando notas de alterações no CHANGELOG.md ..."
        git tag "$THIS_TAG"
        git tag -l
        git push  --tags https://github.com/leoviana00/config-repo-base-autochangelog.git HEAD:main
        chmod +x note-releases.sh
        ./note-releases.sh > CHANGELOG.md
        git add CHANGELOG.md 
        git commit -m "docs(CHANGELOG): update release notes"
        git push origin HEAD:main
    fi
done