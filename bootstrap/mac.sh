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
                  karabiner \
                  seil \
                  mactex \
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
                  betterzipql \
                  qlimagesize \
                  webpquicklook \
                  suspicious-package \
                  quicklookase \
                  qlvideo


# Pip
pip3 install bpython --user
pip3 install gdbgui --user --upgrade


# Sublime-Text
cd '$HOME/Library/Application Support/Sublime Text 3/Packages'
ln -s $HOME/.dotfiles/sublime-text
mv sublime-text User
cd
