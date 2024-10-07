#!/usr/bin/env bash

echo "Setting up homebrew..."

BREW_BINARY=/opt/homebrew/bin/brew

# Install brew
if command -v $BREW_BINARY >/dev/null 2>&1; then
    echo "brew already installed"
else
    echo "installing brew..."
    # source: https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update brew
$BREW_BINARY update

### Cask brews
cask_brews=(
  iterm2
  # karabiner-elements
  # mactex
  rectangle
  spotify
  spotmenu
  thyme
  visual-studio-code
  # vlc
)

# Add quicklook plugins
cask_brews+=(
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlvideo
  quicklookase
  quicklook-csv
  quicklook-json
  suspicious-package
  webpquicklook
  qlcolorcode
)

cask_installed=(`$BREW_BINARY list --cask -1`)

for b in ${cask_brews[@]}; do
  # Check if brew is in list of installed brews
  # https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
  if [[ ! " ${cask_installed[@]} " =~ " ${b} " ]]; then
    $BREW_BINARY install ${b}
  else
    echo "Cask '${b}' already installed!"
  fi
done

### Normal brews
brews=(
  cmake
  colordiff
  # conan # C++ package manager
  coreutils # GNU ls has better color configs
  git
  imagemagick
  # llvm # keep most updated clang
  mosh
  python # override MacOS python
  ruby
  tag
  tmux
  tree
  vim
  watch  # unix watch command
  wget
  zsh
)

installed=(`$BREW_BINARY list --formula -1`)

for b in ${brews[@]}; do
  # Check if brew is in list of installed brews
  if [[ ! " ${installed[@]} " =~ " ${b} " ]]; then
    $BREW_BINARY install ${b}
  else
    echo "'${b}' already installed!"
  fi
done

echo "Finished setting up homebrew."
