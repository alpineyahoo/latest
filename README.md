# latest
This tool downloads and installs the latest new release images/packages from GitHub (for MacOS users).<br>
Optionally you can set some webpages or direct links if available.
## Prerequisites
```shell
brew install gum wget curl jq lynx figlet zsh
```
## Install
```shell
curl -sL https://github.com/alpineyahoo/latest/raw/main/install.sh | zsh
```
## Usage
Just hit `latest`. Command doesn't provide options.

![usage](usage.gif)

Edit `~/Library/Application Support/alpineyahoo.latest/repos.json` to add/remove repos.

## Source
This script is based on Kamil Wozniak's [Article](https://smarterco.de/download-latest-version-from-github-with-curl/).
