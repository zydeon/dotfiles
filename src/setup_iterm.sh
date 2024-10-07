echo "Setting up iterm..."
if [ -d "/Applications/iTerm.app" ]; then
  echo "Setting up iterm..."
  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.dotfiles/iterm"

  # Tell iTerm2 to use the custom preferences in the directory
  # defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi
echo "Done setting up iterm."
