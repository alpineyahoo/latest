#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
repos="$HOME/Library/Application Support/alpineyahoo.latest/repos.txt"
echo "Select repo(s):" &&
latests=$(for i in $(gum choose --no-limit < $repos)
do
curl -sL https://api.github.com/repos/$i/releases/latest |
grep browser_download_url |
grep -e dmg -e pkg -e darwin -e osx -e mac |
grep -v arm |
cut -d '"' -f 4
done) &&
echo "Select file(s):" &&
for i in $(echo $latests | gum choose --no-limit)
do
wget -q --show-progress -P $HOME/Downloads $i &&
name=$(echo $i | rev | cut -d '/' -f 1 | rev) &&
osascript -e '
	on run argv
		display notification ((item 1 of argv) & " downloaded") with title "latest"
	end run
' "$name"
done

# https://github.com/alpineyahoo/latest
