# sources:
# 1. https://github.com/mathiasbynens/dotfiles/blob/main/.macos
# 2. https://macos-defaults.com/
# 3. https://github.com/janka102/dotfiles/blob/master/defaults.sh

# To find out which settings exist
# 1. defaults read > /tmp/settings.plist
# 2. sudo defaults read > /tmp/settings_sudo.plist
# 3. change settings and then: plutil -p ~/Library/Preferences/ByHost/.GlobalPreferences.${UUID}.plist

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
add_login_item Thyme /Applications/Thyme.app false

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
# Pretty print: plutil -p ~/Library/Preferences/ByHost/.GlobalPreferences.${__UUID__}.plist

############################################
# Input sources                            #
############################################

# Show in menu bar
defaults write com.apple.TextInputMenu visible -bool true
defaults write com.apple.TextInputMenuAgent "NSStatusItem Visible Item-0" -bool true

# Add languages
add_input_source () {
  _layout_name=$1
  _layout_id=$2
  _entry="<dict>
    <key>InputSourceKind</key><string>Keyboard Layout</string>
    <key>KeyboardLayout ID</key><integer>$_layout_id</integer>
    <key>KeyboardLayout Name</key><string>$_layout_name</string>
  </dict>"

  # only add if not already present
  if ! defaults read com.apple.HIToolbox AppleEnabledInputSources | grep -q $_layout_name; then
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add $_entry
    echo "Added input source $_layout_name."
  else
    echo "Input source $_layout_name already present."
  fi
}

add_input_source Greek -18944
add_input_source Portuguese 10

############################################
# Mouse, trackpad                          #
############################################

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -bool true

# Enable mission control, app expose
defaults write com.apple.dock showMissionControlGestureEnabled -bool true
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Use 3-finger for mission control, app expose
# (-int 0 for 4-finger)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2

# Disable 2-finger Notification Center
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0


############################################
# Dock                                     #
############################################

# No persistent apps, but also no downloads folder
# defaults write com.apple.dock static-only -bool true

# No persistent apps, but with downloads folder
defaults write com.apple.dock persistent-apps -array

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
# Hot corners                              #
############################################

# Corner values
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# 14: Quick Note

# Modifier values
# 0: no modifier keys
# 262144: Ctrl-key
# 524288: Alt-key
# 1048576: Cmd-key
# 131072: Shift-key
# (keys to hold while pointing to corner)
# (it's also possible to do combinations of up to all 4 modifers)

# Remove all shortcuts
for _corner in tl tr bl br; do
  defaults delete com.apple.dock wvous-$_corner-corner
  defaults delete com.apple.dock wvous-$_corner-modifier
done

# Add shortcuts

# Top right + cmd → Lock screen
defaults write com.apple.dock wvous-tr-corner -int 13
defaults write com.apple.dock wvous-tr-modifier -int 1048576

# Bottom right + cmd → Quick note
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 1048576

############################################
# Night shift                              #
############################################

# source: https://github.com/LukeChannings/dotfiles/blob/7cb3171b5354761c9aef7b6f1094019ef8701a17/install.macos#L413-L433
CORE_BRIGHTNESS_PLIST="/var/root/Library/Preferences/com.apple.CoreBrightness.plist"
_night_shift="<dict>
  <key>CBBlueLightReductionCCTTargetRaw</key><integer>4100</integer>
  <key>CBBlueReductionStatus</key><dict>
    <key>AutoBlueReductionEnabled</key><integer>1</integer>
    <key>BlueLightReductionDisableScheduleAlertCounter</key><integer>3</integer>
    <key>BlueLightReductionSchedule</key><dict>
      <key>DayStartHour</key><integer>4</integer>
      <key>DayStartMinute</key><integer>0</integer>
      <key>NightStartHour</key><integer>4</integer>
      <key>NightStartMinute</key><integer>1</integer>
    </dict>
    <key>BlueReductionAvailable</key><integer>1</integer>
    <key>BlueReductionEnabled</key><integer>1</integer>
    <key>BlueReductionMode</key><integer>2</integer>
    <key>BlueReductionSunScheduleAllowed</key><integer>1</integer>
    <key>Version</key><integer>1</integer>
  </dict>
</dict>"

_UID=$(dscl . -read ~ GeneratedUID | sed 's/GeneratedUID: //')
sudo defaults write $CORE_BRIGHTNESS_PLIST "CBUser-$_UID" $_night_shift
sudo killall corebrightnessd  # to activate settings

############################################
# Done                                     #
############################################

# Activate settings without needing to log out/in
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Restart relevant apps
echo "Restarting relevant apps..."
killall Dock
killall Finder
echo "Restarted Dock, Finder."

echo "Finished setting up macos."
