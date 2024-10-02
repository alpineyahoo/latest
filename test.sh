#!/usr/bin/env bash

# echo "apple/pkl" |
# xargs -I _ gh release list -R _ --exclude-drafts --exclude-pre-releases \
# --json createdAt,isLatest,name,publishedAt,tagName -q '.[] | select(.isLatest == true)' |
# jq

# 最新版リリースのタグ値取得. "-L 3" オプションは1でもいい気がするが念のため3
gh release list -R apple/pkl --exclude-drafts --exclude-pre-releases -L 3 |
grep Latest |
awk '{print $3}' |
# xargs -I _ gh release view _ -R apple/pkl
xargs -I _ gh release view _ -R apple/pkl \
--json apiUrl,assets,author,body,createdAt,databaseId,id,name,publishedAt,tagName,tarballUrl,targetCommitish,uploadUrl,url,zipballUrl \
-q '.assets[] | select(.name | test("mac|osx|darwin"))' |
jq

# gh release download
