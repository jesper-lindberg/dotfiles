#!/bin/sh
echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s $(which fish)

# Install Fisher (Fish Package Manager)
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Symlink fish config
ln -s ~/.dotfiles/config.fish ~/.config/fish/config.fish
ln -s ~/.dotfiles/fishfile ~/.config/fish/fishfile

# Set OS X preferences
source .osx

# Symlink .vimrc file to the home directory
ln -s ~/.dotfiles/.vimrc ~/.vimrc
