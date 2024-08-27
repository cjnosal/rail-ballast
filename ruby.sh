#!/usr/bin/env bash
set -euo pipefail

cd /home/ubuntu/

# install rbenv
wget https://github.com/rbenv/rbenv/archive/refs/tags/v1.3.0.tar.gz
tar -xf v1.3.0.tar.gz && mv rbenv-1.3.0/* .rbenv && rm v1.3.0.tar.gz
chown -R ubuntu:ubuntu .rbenv

# add build plugin
wget https://github.com/rbenv/ruby-build/archive/refs/tags/v20240727.tar.gz
tar -xf v20240727.tar.gz && mkdir /home/ubuntu/.rbenv/plugins && mv ruby-build-20240727 /home/ubuntu/.rbenv/plugins/ruby-build
rm v20240727.tar.gz

# init
source ~/.bashrc
export PATH=${PATH}:/home/ubuntu/.rbenv/bin:/home/ubuntu/.rbenv/shims
bash -c "/home/ubuntu/.rbenv/bin/rbenv init"

# install ruby
rbenv install 3.3.4 # compiles from source
rbenv global 3.3.4
rbenv rehash