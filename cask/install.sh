
#!/usr/bin/env bash
# ****************************************************
#
#   Setup - Cask
#
# ****************************************************

# to maintain cask ....
# brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`

echo "installing apps..."

brew tap caskroom/cask
brew install brew-cask
brew tap caskroom/versions
brew tap caskroom/fonts

# daily
brew cask install caffeine 2> /dev/null
brew cask install dashlane 2> /dev/null
brew cask install dropbox 2> /dev/null
brew cask install flux 2> /dev/null
brew cask install slack 2> /dev/null
brew cask install spectacle 2> /dev/null
brew cask install docker 2> /dev/null
brew cask install iterm2 2> /dev/null
brew cask install boostnote 2> /dev/null

# Fonts
brew cask install font-source-code-pro 2> /dev/null
brew cask install font-sauce-code-powerline 2> /dev/null
brew cask install font-source-sans-pro 2> /dev/null

# dev
brew cask install atom 2> /dev/null
brew cask install imageoptim 2> /dev/null
brew cask install transmit 2> /dev/null

# browsers
brew cask install google-chrome 2> /dev/null
brew cask install firefox 2> /dev/null
brew cask install opera 2> /dev/null

# less often
brew cask install appcleaner 2> /dev/null
brew cask install spotify 2> /dev/null
brew cask install the-unarchiver 2> /dev/null
brew cask install elmedia-player 2> /dev/null
