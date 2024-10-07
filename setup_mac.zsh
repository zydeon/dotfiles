#!/usr/bin/env bash

source src/setup_brew.sh
source src/setup_vim.sh
source src/setup_links.sh
source src/setup_iterm.sh
source src/setup_macos.sh
source ~/.zshrc

# Default shell
grep "$(which zsh)" /etc/shells
if [[ $? -eq 1 ]]; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  chsh -s `which zsh`
fi

# Copy fonts
cp $HOME/.dotfiles/fonts/* $HOME/Library/Fonts
 
# Color profiles
rm -rf $HOME/Library/ColorSync/Profiles
mkdir -p $HOME/Library/ColorSync/Profiles
ln -sf $HOME/.dotfiles/Library/ColorSync/Profiles $HOME/Library/ColorSync/Profiles

# Keyboards
cp $HOME/.dotfiles/keylayouts/Mathy.keylayout "$HOME/Library/Keyboard Layouts"

# Make toggle dark mode script executable
chmod +x $HOME/.dotfiles/scripts/darkerrrr.sh
