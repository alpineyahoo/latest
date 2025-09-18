# latest
This tool downloads and installs the latest new release images/packages from GitHub (for MacOS users).<br>
Optionally you can set some webpages or direct links if available.
## Prerequisites
You need to install `gum`, `wget`, `curl` (if necessary), `jq`, `lynx`, `figlet`, and `zsh`.
```shell
brew install gum wget curl jq lynx figlet zsh
```
## Install
```shell
curl -sL https://github.com/alpineyahoo/latest/raw/main/install.sh | zsh
```
## Usage
Just hit `latest` in your terminal. Command provides no options.

![usage](usage.gif)

Edit `~/Library/Application Support/alpineyahoo.latest/repos.json` to add/remove repos.

## Source
This script is based on Kamil Wozniak's [Article](https://smarterco.de/download-latest-version-from-github-with-curl/).
