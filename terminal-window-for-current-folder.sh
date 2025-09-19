#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in Terminal
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "path", "optional": true }

# Documentation:
# @raycast.description Opens a new terminal window to the path of the frontmost Finder window. If a path is provided as an argument, it opens the terminal at that path instead.
# @raycast.author Raycast
# @raycast.authorURL https://raycast.com

if [ -n "$1" ]; then
  # If a path is provided, use it
  the_path="$1"
else
  # Otherwise, get the path from Finder
  the_path=$(osascript -e 'tell application "Finder" to get the POSIX path of (target of front window as alias)')
fi

# Open a new terminal window at the specified path
open -a Terminal "$the_path"

