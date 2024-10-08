#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
repos="$HOME/Library/Application Support/alpineyahoo.latest/repos.txt"
echo "Select repo(s):" &&
latests=$(for i in $(gum choose --no-limit < $repos)
do
curl -sL https://api.github.com/repos/$i/releases/latest |
grep browser_download_url |
grep -E 'dmg|pkg|darwin|osx|mac' |
grep -v x86 |
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

# ~/Downloads/<package>.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.app

# https://github.com/alpineyahoo/latest
