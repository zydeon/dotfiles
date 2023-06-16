# Reset links
rm -rf $HOME/.dir_colors
rm -rf $HOME/.gdbinit
rm -rf $HOME/.gitconfig
rm -rf $HOME/.hushlogin
rm -rf $HOME/.lldbinit
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.zshrc
rm -rf $HOME/.tmux
rm -rf $HOME/.tmux.conf
rm -rf $HOME/Library/Application\ Support/Code/User/settings.json

# Setup links
ln -sf $HOME/.dotfiles/.hushlogin $HOME/.hushlogin
ln -sf $HOME/.dotfiles/ssh/config $HOME/.ssh
ln -sf $HOME/.dotfiles/dir_colors $HOME/.dir_colors
ln -sf $HOME/.dotfiles/gdb/gdbinit $HOME/.gdbinit
ln -sf $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig
ln -sf $HOME/.dotfiles/lldb/lldbinit $HOME/.lldbinit
ln -sf $HOME/.dotfiles/vim $HOME/.vim
ln -sf $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles/tmux $HOME/.tmux
ln -sf $HOME/.dotfiles/tmux/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.dotfiles/zsh/oh-my-zsh $HOME/.oh-my-zsh
ln -sf $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User
