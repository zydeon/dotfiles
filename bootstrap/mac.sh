#!/usr/bin/env bash

# Install brew

brew update

### Cask brews
cask_brews=(
  brave-browser
  dropbox
  flux
  inkscape
  iterm2
  karabiner-elements
  mactex
  nomachine # remote screen
  skim
  slack
  spectacle
  spotify
  sublime-text
  telegram
  thyme
  vlc
  xquartz
)

# Added quicklook plugins
cask_brews+=(
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  qlvideo
  quicklookase
  quicklook-csv
  quicklook-json
  suspicious-package
  webpquicklook
)

cask_installed=(`brew cask list`)

for b in ${cask_brews[@]}; do
  # Check if brew is in list of installed brews
  # https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
  if [[ ! " ${cask_installed[@]} " =~ " ${b} " ]]; then
    brew cask install ${b}
  else
    echo "Cask '${b}' already installed!"
  fi
done

### Normal brews
brews=(
  cmake
  colordiff
  conan # C++ package manager
  coreutils # GNU ls has better color configs
  gdb
  git
  hugo
  llvm # keep most updated clang
  pandoc pandoc-citeproc
  python # override MacOS python
  pypy3
  reattach-to-user-namespace # enable subl in tmux
  ruby
  tag
  tmux
  tree
  vim
  wget
  zsh
)

installed=(`brew list`)

for b in ${brews[@]}; do
  # Check if brew is in list of installed brews
  if [[ ! " ${installed[@]} " =~ " ${b} " ]]; then
    brew install ${b}
  else
    echo "'${b}' already installed!"
  fi
done


# Pip
pip3 install bpython --user
pip3 install gdbgui --user --upgrade


# Default shell
grep "$(which zsh)" /etc/shells
if [[ $? -eq 1 ]]; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s `which zsh`
fi

# Copy fonts
cp $HOME/.dotfiles/fonts/* $HOME/Library/Fonts

### Links

# Setup folders
mkdir -p $HOME/.config

# Reset links
rm -rf "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
rm -rf $HOME/.config/inkscape/keys
rm -rf $HOME/.config/inkscape/preferences.xml
rm -rf $HOME/Library/ColorSync/Profiles
rm -rf $HOME/Library/Preferences/com.googlecode.iterm2.plist

# Setup links
ln -sf $HOME/.dotfiles/sublime-text "$HOME/Library/Application Support/Sublime Text 3/Packages/User" # Install package manager 
ln -sf $HOME/.dotfiles/inkscape/keys $HOME/.config/inkscape/keys
ln -sf $HOME/.dotfiles/inkscape/preferences.xml $HOME/.config/inkscape/preferences.xml
ln -sf $HOME/.dotfiles/Library/ColorSync/Profiles $HOME/Library/ColorSync/Profiles
ln -sf $HOME/.dotfiles/iterm2/com.googlecode.iterm2.plist $HOME/Library/Preferences/
ln -sf $HOME/.dotfiles/spectacle/Shortcuts.json "$HOME/Library/Application Support/Spectacle"
ln -sf $HOME/.dotfiles/python/pythonrc.py "$HOME/.pythonrc.py"

# Common dotfiles boostrap
source $HOME/.dotfiles/bootstrap/dotfiles.sh
