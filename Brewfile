# Cross-platform Brewfile for macOS and Linux

# Install fish
brew 'fish'

# Install eza. A modern replacement to ls
brew 'eza'

# Install GNU core utilities (those that come with OS X are outdated)
brew 'coreutils'

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew 'findutils'

# Install CLI tools
brew 'ripgrep'
brew 'fzf'
brew 'hub'
brew 'tree'
brew 'wget'
brew 'git'
brew 'neovim'
brew 'node'
brew 'go'
brew 'git-delta'
brew 'k3d'
brew 'kubectl'
brew 'skaffold'
brew 'helm'
brew 'k9s'
brew 'starship'
brew 'fisher'
brew 'utf8proc'
brew 'mise'

# macOS-specific packages
if OS.mac?
  # Make sure apps get installed in system Applications dir
  cask_args appdir: '/Applications'

  # macOS-specific CLI tool
  brew 'trash'

  # AI
  cask 'claude-code'

  # Development
  cask 'orbstack'
  cask 'macdown'
  cask 'gcloud-cli'
  cask 'ghostty'
  cask 'zed'

  # Apps
  cask 'aerial'
  cask 'dash'
  cask 'firefox'
  cask 'github'
  cask 'google-chrome'
  cask 'spotify'
  cask 'tower'
  cask 'transmit'
  cask 'vlc'
  cask 'hammerspoon'
  cask 'visual-studio-code'

  # Quicklook
  cask 'qlcolorcode'
  cask 'qlmarkdown'
  cask 'quicklook-json'
  cask 'quicklook-csv'
  cask 'qlstephen'

  # Fonts
  cask 'font-source-code-pro'
  cask 'font-inconsolata'
  cask 'font-fira-code'
end

# Linux-specific packages
if OS.linux?
  # Linux alternatives or equivalents can be added here
  # Note: Many GUI apps would need to be installed via system package manager
end
