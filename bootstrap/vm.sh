# Get more recent package versions:
# Add the following to /etc/apt/sources.list
# deb http://deb.debian.org/debian/ buster main
# deb-src http://deb.debian.org/debian/ buster main
sudo apt-get update

sudo apt-get install git
sudo apt-get install zsh
sudo apt-get install tmux
sudo apt-get install htop
sudo apt-get install tree
sudo apt-get install clang-6.0
sudo apt-get install cmake
sudo apt-get install cmake-curses-gui  # for ccmake



ssh-keygen -t rsa -b 4096 -C "pedro@pmatias.com"
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa
# DO: add SSH public key to Github

cd
git clone --recursive git@github.com:zydeon/dotfiles .dotfiles
ln -s $HOME/.dotfiles/dir_colors $HOME/.dir_colors
ln -s $HOME/.dotfiles/gdb/gdbinit $HOME/.gdbinit
ln -s $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
ln -s $HOME/.dotfiles/.hushlogin $HOME/.hushlogin
ln -s $HOME/.dotfiles/lldb/lldbinit $HOME/.lldbinit
ln -s $HOME/.dotfiles/zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -s $HOME/.dotfiles/tmux/tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/vim $HOME/.vim
ln -s $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc

### Oh-my-zsh plugins
for p in zsh-autosuggestions zsh-syntax-highlighting; do
  git clone https://github.com/zsh-users/$p \
    ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/$p
done



### Setup git server
sudo adduser git
su git
cd
mkdir .ssh && chmod 700 .ssh
touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys
# DO: cat /tmp/id_rsa.john.pub >> $HOME/.ssh/authorized_keys

# Forbid remote users to have shell access
su git
cd
mkdir git-shell-commands
cat >git-shell-commands/no-interactive-login <<\EOF
#!/bin/sh
printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
printf '%s\n' "provide interactive shell access."
exit 128
EOF
chmod +x git-shell-commands/no-interactive-login

# switch back to sudo user
cat /etc/shells   # see if `git-shell` is already in there.  If not...
which git-shell   # make sure git-shell is installed on your system.
sudo vim /etc/shells  # and add the path to git-shell from last command
sudo chsh git -s $(which git-shell)

# Create repo on server side
su git
cd
mkdir project.git && cd project.git
git init --bare
# Push changes from client side
git remote add upstream git@gitserver:project.git
git push -u upstream master
