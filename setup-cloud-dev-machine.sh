#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y git tmux vim-nox mosh

# Install guardian-agent for ssh agent forwarding over mosh
sudo apt install -y openssh-client autossh ssh-askpass
curl -L https://api.github.com/repos/StanfordSNR/guardian-agent/releases/latest | grep browser_download_url | grep 'linux' | cut -d'"' -f 4 | xargs curl -Ls | tar xzv
sudo cp sga_linux_amd64/* /usr/local/bin
