#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
repos="$HOME/Library/Application Support/alpineyahoo.latest/repos.txt"
echo "Select repo(s):" &&
latests=$(for i in $(gum choose --no-limit < $repos)
do
curl -sL https://api.github.com/repos/$i/releases/latest |
grep browser_download_url |
grep -E 'dmg|pkg|darwin|osx|mac' |
grep -v arm |
cut -d '"' -f 4
done) &&
echo "Select file(s):" &&
for i in $(echo $latests | gum choose --no-limit)
do
wget -q --show-progress -P $HOME/Downloads $i &&
name=$(echo $i | rev | cut -d '/' -f 1 | rev) &&
osascript << EOF
  display notification ("${name}" & " downloaded") with title "latest"
EOF

done

for i (~/Downloads/*.pkg(N)) (
  echo "Installing $i"
  sudo installer -pkg "$i" -target / &&
  rm "$i"
)
for i (~/Downloads/*.dmg(N)) (
  volume=$(hdiutil attach "$i" | awk 'END{print $3}')
  echo "Installing $i"
  for j ("$volume"/*.app(N)) sudo command cp -R "$j" /Applications # overwrites existing app
  for j ("$volume"/*.pkg(N)) sudo installer -pkg "$j" -target /
  hdiutil detach "$volume" &&
  rm "$i"
)

# command ls -1 ~/Downloads | grep -E 'dmg|pkg' | fzf --reverse | xargs -I _ echo ~/Downloads/_
# for i in ~/Downloads/*.pkg(N); do hello; done
# for i in ~/Downloads/*.dmg(N); do hello; done
# hdiutil attach ~/Downloads/*.dmg | awk 'END{print $3}'
# hdiutil attach ~/Downloads/*.dmg | awk 'END{print $3}' | xargs -I _ zsh -c 'echo "_"/*.app'
# for i (~/Downloads/*.pkg(N)) echo "${i}"
# for i ($(seq 1 5)) (echo Hello; echo "${i}")

# ~/Downloads/<package>.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.app

# https://github.com/alpineyahoo/latest
