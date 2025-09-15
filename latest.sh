#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&
repos="$HOME/Library/Application Support/alpineyahoo.latest/repos.json"
[[ $(uname -m) == 'x86_64' ]] && archt="arm" || archt="x86" # check if Intel or ARM, select opposite (invert match)
gh_latest(){
  curl -sL https://api.github.com/repos/$1/releases/latest |
  grep browser_download_url |
  grep -E 'dmg|pkg|darwin|osx|mac|zip' |
  grep -v "$archt" |
  cut -d '"' -f 4;
}
get_link(){
  src="$(jq -r 'path(.[] | select(.'$1' != null))[0]' $repos)"
  value="$(jq -r '.'$src'.'$1'' $repos)"
  case "$src" in
    "github" ) gh_latest "$value" ;;
    "webpage" ) lynx -dump -listonly -nonumbers "$value" | grep -E 'dmg|pkg|darwin|osx|mac|zip' | grep -v "$archt" ;;
    "direct" ) curl -sIL "$value" | grep -i "location" | awk '{print $2}' | tr -d "\r" ;;
  esac;
}
figlet -f basic latest # display ASCII
echo "Select repo(s):" &&
latests=$(for i ($(jq -r '.[] | keys[]' $repos | gum choose --no-limit)) (get_link "$i")) &&
[[ -z "$latests" ]] &&
echo "GitHub REST API requests rate limit exceeded. Try again later." ||
echo "Select file(s):" &&
for i in $(echo $latests | gum choose --no-limit)
do
until wget -q -c --show-progress -P $HOME/Downloads $i; do :; done &&
name=$(echo $i | rev | cut -d '/' -f 1 | rev) &&
osascript << EOF
  display notification ("${name}" & " downloaded") with title "latest"
EOF

done

for i (~/Downloads/*.pkg(N)) (
  echo "Installing $(basename $i)"
  sudo installer -pkg "$i" -target / &&
  rm "$i"
)
for i (~/Downloads/*.dmg(N)) (
  volume=$(hdiutil attach "$i" | tail -n 1 | cut -f 3-) # 契約書を認める必要あり(Agree Y/N?)
  echo "Installing $(basename $i)"
  for j ("$volume"/*.app(N)) sudo command cp -R "$j" /Applications # overwrites existing app
  for j ("$volume"/*.pkg(N)) sudo installer -pkg "$j" -target /
  hdiutil detach "$volume" &&
  rm "$i"
)

# https://github.com/alpineyahoo/latest
