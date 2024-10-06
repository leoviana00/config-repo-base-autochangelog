#!/bin/bash

echo "# 🎁 Release notes"

git tag --sort=-creatordate | while read TAG ; do
    echo
    if [ $NEXT ];then
        tag_date=$(git log -1 --pretty=format:'%ad' --date=short ${TAG})
        echo "## $NEXT - ($tag_date)"
    else
        echo "## Current"
    fi  
    echo "## Merges"
    GIT_PAGER=cat git log ${TAG}...${NEXT} --merges --pretty=format:'*  %s [View](https://github.com/leoviana00/config-repo-base-autochangelog/commits/%H)' 
    echo 
    echo "## Commits"
    GIT_PAGER=cat git log ${TAG}...${NEXT} --pretty=format:'*  %s [View](https://github.com/leoviana00/config-repo-base-autochangelog/commits/%H)' --reverse | grep -v Merge
    NEXT=$TAG
    printf "\n\n"
done
FIRST=$(git tag -l --sort=v:refname | head -1)
tag_date=$(git log -1 --pretty=format:'%ad' --date=short ${FIRST})
echo
echo "# $FIRST - ($tag_date)"
echo "## Merges"
GIT_PAGER=cat git log ${FIRST} --merges --pretty=format:'*  %s [View](https://github.com/leoviana00/config-repo-base-autochangelog/commits/%H)' 
echo 
echo "## Commits"
GIT_PAGER=cat git log ${FIRST} --pretty=format:'*  %s [View](https://github.com/leoviana00/config-repo-base-autochangelog/commits/%H)' --reverse | grep -v Merge

#METADATA

DATE=$(git log -1 --pretty=format:'%ad' --date=short)
VERSION=$(git tag --sort=-committerdate | head -5)
PREVIOUS_VERSION=$(git tag --sort=-committerdate | head -2 | awk '{split($0, tags, "\n")} END {print tags[1]}')
CHANGES=$(git log --pretty="- %s" $VERSION...$PREVIOUS_VERSION)
# printf "# 🎁 Release notes (\`$VERSION\`)\n\n## Changes\n$CHANGES\n\n## Metadata\n\`\`\`\nThis version -------- $VERSION\nPrevious version ---- $PREVIOUS_VERSION\nTotal commits ------- $(echo "$CHANGES" | wc -l)\n\`\`\`\n" 
printf "## 📝 Metadata\n\`\`\`\nThis version -------- $VERSION\nPrevious version ---- $PREVIOUS_VERSION\nTotal commits ------- $(echo "$CHANGES" | wc -l)\n\`\`\`\n" 