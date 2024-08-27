#!/usr/bin/env bash
set -eu

# install nvm
curl -fsSL -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# init
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.bashrc

# install node
nvm install 20
nvm use 20

# enable corepack package manager
npm install -g corepack
source ~/.bashrc
corepack enable