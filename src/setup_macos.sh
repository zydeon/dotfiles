# sources:
# 1. https://github.com/mathiasbynens/dotfiles/blob/main/.macos
# 2. https://macos-defaults.com/

# To find out which settings exist
# 1. defaults read > /tmp/settings.plist
# 2. change settings and then: plutil -p ~/Library/Preferences/ByHost/.GlobalPreferences.${UUID}.plist

echo "Setting up macos..."

# Close system settings
killall "System Settings" 2> /dev/null
echo "Closed System Settings to avoid concurrent settings changes."

############################################
# Login items                              #
############################################

add_login_item () {
  _name=$1
  _path=$2
  _hide=$3
  echo "Login items: adding $_name, path=$_path, hide=$_hide"

  osascript <<APPLESCRIPT
tell application "System Events"
  if (login item "$_name" exists) is false then
    make login item at end with properties {name:"$_name", path:"$_path", hidden:"$_hide"}
  end if
end tell
APPLESCRIPT
}

add_login_item SpotMenu /Applications/SpotMenu.app true
add_login_item Spotify /Applications/Spotify.app false

############################################
# Finder                                   #
############################################

# Hidden files
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Column view by default
# source: https://macos-defaults.com/finder/fxpreferredviewstyle.html
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Show path bar
defaults write com.apple.finder "ShowPathbar" -bool "true"

# Folders on top
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Search current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# Changing file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Tollbar title rollover delay
# source: https://macos-defaults.com/finder/nstoolbartitleviewrolloverdelay.html
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"

############################################
# Bluetooth                                #
############################################

# Bluetooth in menu bar
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist Bluetooth -int 18

# Sidebar icon size
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "3"

############################################
# Keyboard                                 #
############################################

# Make keyboard fast (to update on System Settings requires re-launching it)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Keyboard modifier keys
# source: https://stackoverflow.com/a/58907582
__UUID__=$(
  ioreg -ad2 -c IOPlatformExpertDevice | xmllint --xpath \
  '//key[.="IOPlatformUUID"]/following-sibling::*[1]/text()' -
)
plutil -replace "com\.apple\.keyboard\.modifiermapping\.0-0-0" \
-json '[{
 "HIDKeyboardModifierMappingDst": 30064771113,
 "HIDKeyboardModifierMappingSrc": 30064771129
}]' \
~/Library/Preferences/ByHost/.GlobalPreferences.${__UUID__}.plist
# Pretty print
# plutil -p ~/Library/Preferences/ByHost/.GlobalPreferences.${__UUID__}.plist 

############################################
# Mouse, trackpad                          #
############################################

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

############################################
# Dock                                     #
############################################

# Only open applications
defaults write com.apple.dock static-only -bool true

# Size
defaults write com.apple.dock tilesize -int 60

# Activate auto-hide
defaults write com.apple.dock autohide -bool true

# No recent apps
defaults write com.apple.dock show-recents -bool false

# hide/show delay
defaults write com.apple.dock autohide-delay -float 0

# hide/show animation time (0.5s is default)
defaults write com.apple.dock autohide-time-modifier -float 0.5
# to reset: defaults delete com.apple.dock "autohide-time-modifier"

############################################
# Activate                                 #
############################################

# Activate settings without needing to log out/in
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Restart relevant apps
echo "Restarting relevant apps..."
killall Dock
killall Finder
echo "Restarted Dock, Finder."

echo "Finished setting up macos."
