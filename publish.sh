#!/bin/bash

set -e

file_to_upload=$1
tag="v$2"

latest_tag=$(curl --silent https://api.github.com/repos/$CIRRUS_REPO_FULL_NAME/releases/latest | jq -r '.tag_name')
if [[ "$tag" == "${latest_tag%.*}" ]]
then
    build_number=$((${latest_tag##*.}+1))
    tag="$tag.$build_number"
else
    tag="$tag.0"
fi

release_id=$(curl --silent -X POST \
    --data "{\"tag_name\":\"$tag\", \"target_commitish\":\"$CIRRUS_CHANGE_IN_REPO\"}" \
    --header "Authorization: token $GITHUB_TOKEN" \
    --header "Content-Type: application/json" \
    "https://api.github.com/repos/$CIRRUS_REPO_FULL_NAME/releases" \
    | jq -r '.id')

zip_to_upload="/tmp/$(basename ${file_to_upload%.*}).zip"
zip -FS -j $zip_to_upload $file_to_upload
curl --silent -X POST \
    --data-binary @$zip_to_upload \
    --header "Authorization: token $GITHUB_TOKEN" \
    --header "Content-Type: application/zip" \
    "https://uploads.github.com/repos/$CIRRUS_REPO_FULL_NAME/releases/$release_id/assets?name=$(basename $zip_to_upload)" \
    > /dev/null
