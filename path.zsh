# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Load custom commands
export PATH="$DOTFILES/bin:$PATH"

# Local bin directories before anything else
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Dotfiles path
export DOTFILES=$HOME/.dotfiles

# Export GOPATH
export GOPATH=~/dev/go
export GOPRIVATE="github.com/sybogames"

# Include Go binaries in PATH
export PATH=~/dev/go/bin:/usr/local/sbin:/usr/local/bin:$PATH
