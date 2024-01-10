#!/usr/bin/env zsh

mkdir -p $HOME/Library/Application\ Support/alpineyahoo.latest
curl -sL https://github.com/alpineyahoo/latest/raw/main/repos.txt >> $HOME/Library/Application\ Support/alpineyahoo.latest/repos.txt
curl -sL https://github.com/alpineyahoo/latest/raw/main/latest.sh >> latest
chmod 700 latest
echo "Executable \"latest\" is downloaded in current directory.\nMove it to desired location, e.g. /usr/local/bin/latest"
