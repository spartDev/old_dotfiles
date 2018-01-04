
#!/usr/bin/env bash
# ****************************************************
#
#   Setup - NPM
#
# ****************************************************

if test ! $(which nvm)
then
  echo "installing node packages..."
fi

packages=(
  imageoptim-cli
  nodemon
  stylestats
  svgo
  eslint
  updtr
  webpack
  yarn
  yo
)

for package in ${packages[@]}; do
  . ~/.nvm/nvm.sh && npm install -g $package
done
