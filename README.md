# latest
This tool downloads and installs the latest new release images/packages from GitHub (for MacOS users)
## Prerequisites
```shell
brew install gum wget
```
## Install
```shell
curl -sL https://github.com/alpineyahoo/latest/raw/main/install.sh | zsh
```
## Usage
```shell
latest
```
Edit `~/Library/Application Support/alpineyahoo.latest/repos.txt` to add/remove repos.

## Source
This script is based on Kamil Wozniak's [Article](https://smarterco.de/download-latest-version-from-github-with-curl/).
