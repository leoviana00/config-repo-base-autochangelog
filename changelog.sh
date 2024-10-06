#!/bin/bash

version=$(cat version.json | grep version | grep -Eo "[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+")

if [ $(git tag -l "$version") ]; then
    echo "Tag $version já existe. Adicionando alterações no CHANGELOG.md ..."
    chmod +x note-releases.sh
    ./note-releases.sh > CHANGELOG.md
    git add CHANGELOG.md 
    git commit -m "docs(CHANGELOG): update release notes"
    git push origin HEAD:main
else
    echo "Tag $version não exite. Criando tag e adicionando notas de alterações no CHANGELOG.md ..."
    # cd config-repo-base-autochangelog
    git tag "$version"
    git tag -l
    git push  --tags 
    chmod +x note-releases.sh
    ./note-releases.sh > CHANGELOG.md
    git add CHANGELOG.md 
    git commit -m "docs(CHANGELOG): update release notes"
    git push origin HEAD:main
fi