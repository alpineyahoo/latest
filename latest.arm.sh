#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
repos="$HOME/Library/Application Support/alpineyahoo.latest/repos.txt"
figlet -f basic latest
echo "Select repo(s):" &&
latests=$(for i in $(gum choose --no-limit < $repos)
do
curl -sL https://api.github.com/repos/$i/releases/latest |
grep browser_download_url |
grep -E 'dmg|pkg|darwin|osx|mac|zip' |
grep -v x86 |
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
  volume=$(hdiutil attach "$i" | tail -n 1 | cut -f 3-) # 契約書を認める必要あり(Agree Y/N?)
  echo "Installing $i"
  for j ("$volume"/*.app(N)) sudo command cp -R "$j" /Applications # overwrites existing app
  for j ("$volume"/*.pkg(N)) sudo installer -pkg "$j" -target /
  hdiutil detach "$volume" &&
  rm "$i"
)

# ~/Downloads/<package>.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.pkg

# ~/Downloads/<image>.dmg, /Volumes/<image>/*.app

# https://github.com/alpineyahoo/latest
