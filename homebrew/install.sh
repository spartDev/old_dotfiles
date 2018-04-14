#!/usr/bin/env bash
# ****************************************************
#
#   Install - Homebrew
#
# ****************************************************

# Ask for the administrator password upfront.
sudo -v

# Check for Homebrew and install if we don't have it
if test ! $(which brew)
then
  echo "Installing Homebrew ..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "installing binaries..."

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# Bash & Bash Completion
brew install bash
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php71 --with-gmp

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# MAS
# -> Mac App Store command-line interface
brew install mas

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install git
brew install git-lfs
brew install webkit2png
brew install imagemagick --with-webp
brew install ssh-copy-id
brew install mackup

# Updated python/pip
brew install python
pip install --upgrade setuptools
pip install --upgrade pip

# Install `itermocil` to create pre-defined window/pane layouts and run commands in iTerm
# https://github.com/TomAnthony/itermocil
brew install TomAnthony/brews/itermocil

# verify
brew doctor

# Remove outdated versions from the cellar
brew cleanup
