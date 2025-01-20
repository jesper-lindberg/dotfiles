#!/bin/sh
OS=$(uname)

echo "Setting up your machine..."

# Check if the operating system is macOS
if [[ "$OS" == "Darwin" ]]; then
    echo "Running macOS specific steps..."
    
    # Install OS X Command Line Tools
    xcode-select --install

    # Check for Homebrew and install if we don't have it
    if test ! $(which brew); then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Update Homebrew recipes
    brew update

    # Install all our dependencies with bundle (See Brewfile)
    brew tap homebrew/bundle
    brew bundle

    # Symlink hammerspoon directory
    ln -s ~/.dotfiles/config/hammerspoon ~/.hammerspoon
elif [[ "$OS" == "Linux" ]]; then
    echo "Running Linux specific steps..."
fi

# Make fish the default shell environment
chsh -s $(which fish)

# Symlink fish directory
ln -s ~/.dotfiles/config/fish ~/.config/fish

# Symlink neovim directory
ln -s ~/.dotfiles/config/nvim ~/.config/nvim

# Symlink starship.toml file
ln -s ~/.dotfiles/config/starship.toml ~/.config/starship.toml
