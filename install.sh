#!/bin/sh
echo "Setting up your machine..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make fish the default shell environment
chsh -s $(which fish)

# Symlink fish directory
ln -s ~/.dotfiles/config/fish ~/.config/fish

# Symlink neovim directory
ln -s ~/.dotfiles/config/nvim ~/.config/nvim

# Symlink starship.toml file
ln -s ~/.dotfiles/config/starship.toml ~/.config/starship.toml
