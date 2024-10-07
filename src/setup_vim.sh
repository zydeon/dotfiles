#!/usr/bin/env bash
echo "Setting up vim..."
vim -es +'PlugInstall --sync' +qa
echo "Finished setting up vim."
