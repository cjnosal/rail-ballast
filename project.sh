#!/usr/bin/env bash
set -eu

# init rbenv
eval "$(~/.rbenv/bin/rbenv init - --no-rehash bash)"
export PATH=${PATH}:/home/ubuntu/.rbenv/bin:/home/ubuntu/.rbenv/shims:/home/ubuntu/my-project/bin

# init nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# create rails project
gem update --system
gem install rails -v 7.2.1
gem install foreman
echo Y | rails new my-project --css=tailwindcss --javascript=esbuild --database=sqlite3 --skip-bundle 
cd my-project

# remove platform restriction on tzinfo-data
sed -i'' -e 's|"tzinfo-data", platforms: %i[ windows jruby ]|"tzinfo-data"|' Gemfile

# configure typescript react and tailwind
bundle install
bundle exec rails javascript:install:esbuild
yarn add react react-dom react-router-dom
bundle add tailwindcss-rails
rails tailwindcss:install
rake tailwindcss:build

# create a default controller with react frontend
rails g controller Homepage index

rm app/javascript/application.js
cat <<EOF > app/javascript/application.tsx
import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { createRoot } from 'react-dom/client';
import App from './components/App'

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementsByTagName("main")[0].appendChild(document.createElement("div"))
  const root = createRoot(container!);
  root.render(<App />)
})
EOF

sed -i'' -e 's|get "homepage/index"|root "homepage#index"|' config/routes.rb
truncate -s0 app/views/homepage/index.html.erb
mkdir app/javascript/components

cat <<EOF > app/javascript/components/App.tsx
import React, { useState } from 'react'

const App: React.FC = () => {
  return (
    <div>
      <h1 className="text-3xl font-bold underline">React App UI</h1>
    </div>
  )
}

export default App

EOF

# Adjust network bindings for docker container
sed -i'' -e 's|rails server|rails server -b 0.0.0.0|' Procfile.dev

sed -i'' -e 's|^end$||' config/environments/development.rb
cat << EOF >> config/environments/development.rb  
  config.web_console.whitelisted_ips = '172.16.0.0/12'
end
EOF
