#!/usr/bin/env bash
# Inspired by https://gist.github.com/scmx/2617c680eb4927d80dfdfac3822362ea
# 
# Steps for global keyboard shortcut:
# 1. Save this script as $HOME/.dotfiles/scripts/darkerrrr.sh
# 2. chmod +x $HOME/.dotfiles/scripts/darkerrrr.sh
# 3. Create a new "Run Shell Script" in Automator.app
# 4. Add "$HOME/.dotfiles/scripts/darkerrrr.sh" as its contents
# 5. Open Keyboard Shortcut in System Preferences
# 6. Under Services tab, select "darkerrrr" and give a shortcut

set -e

# Get current dark mode from system
is_darkerrrr=`osascript <<APPLESCRIPT
tell application "System Events"
	tell appearance preferences
		return (get dark mode)
	end tell
end tell
APPLESCRIPT`

# Toggle system
[[ $is_darkerrrr == true ]] && toggle=false || toggle=true
osascript <<APPLESCRIPT
tell application "System Events"
	tell appearance preferences
		set dark mode to $toggle
	end tell
end tell
APPLESCRIPT

# Toggle tmux
[[ $is_darkerrrr == true ]] && toggle=white || toggle=black
/opt/homebrew/bin/tmux set-env -g BGCOLOR $toggle
/opt/homebrew/bin/tmux source-file $HOME/.dotfiles/tmux/tmux_colors.conf

# Toggle vim
# if [[ $? -eq 0 ]]; then
#   for name in ${vim_instances[@]}; do
#     if [[ -f $HOME/.dark-mode ]]; then
#       nvr --servername "$name" -cc ":colorscheme onehalfdark"
#     else
#       nvr --servername "$name" -cc ":colorscheme onehalflight"
#     fi
#   done
# fi
