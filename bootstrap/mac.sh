#!/usr/bin/env bash

# 1 - Install brew

# 2 - App brews
brew cask install iterm2 \
                  spotify \
                  sublime-text \
                  dropbox \
                  spectacle \
                  flux \
                  skim \
                  vlc \
                  karabiner-elements \
                  mactex \
                  xquartz \
                  inkscape \
                  nomachine `# remote screen`

# 3 - Normal brews
brew install zsh \
             tmux \
             reattach-to-user-namespace `# enable subl in tmux` \
             git \
             vim \
             cmake \
             coreutils `# GNU ls has better color configs` \
             python `# override MacOS python` \
             python3 \
             pypy3 \
             wget \
             ruby \
             colordiff \
             llvm  `# keep most updated clang` \
             gdb \
             `#conan # C++ package manager` \
             tag \
             pandoc pandoc-citeproc


# To maintain both clang versions
# ln -s /usr/local/opt/llvm/bin/clang /usr/local/bin/clang6




# Some quicklook plugins
brew cask install qlcolorcode \
                  qlstephen \
                  qlmarkdown \
                  quicklook-json \
                  qlprettypatch \
                  quicklook-csv \
                  qlimagesize \
                  webpquicklook \
                  suspicious-package \
                  quicklookase \
                  qlvideo


# Pip
pip3 install bpython --user
pip3 install gdbgui --user --upgrade


### Links

echo $HOME
exit 0

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
ln -sf $HOME/.dotfiles/inkscape/keys $HOME/.config/inkscape/
ln -sf $HOME/.dotfiles/inkscape/preferences.xml $HOME/.config/inkscape/
ln -sf $HOME/.dotfiles/Library/ColorSync/Profiles $HOME/Library/ColorSync/
ln -sf $HOME/.dotfiles/iterm2/com.googlecode.iterm2.plist $HOME/Library/Preferences/

source $HOME/.dotfiles/bootstrap/dotfiles.sh
