#!/usr/bin/env zsh

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin" &&

for i (~/Downloads/*.pkg(N)) (
  sudo installer -pkg "$i" -target / &&
  rm "$i"
)
for i (~/Downloads/*.dmg(N)) (
  volume=$(hdiutil attach "$i" | awk 'END{print $3}')
  for j ($volume/*.app(N)) sudo command cp -R "$j" /Applications # overwrites existing app
  for j ($volume/*.pkg(N)) sudo installer -pkg "$j" -target /
  hdiutil detach "$volume" &&
  rm "$i"
)
