#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin"
echo "Select repo(s):"
repos=$(gum choose --no-limit < $HOME/Library/Application\ Support/alpineyahoo.latest/repos.txt)
latests=$(for i in $repos; do curl -sL https://api.github.com/repos/${i}/releases/latest |
grep browser_download_url |
grep -e dmg -e pkg -e darwin -e osx -e mac |
cut -d '"' -f 4; done)
echo "Select file(s) to download:"
selection=$(gum choose --no-limit $latests)
for i in $selection; do wget -nv -P $HOME/Downloads $i; done
