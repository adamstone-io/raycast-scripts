#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste timestamp
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# @raycast.author Adam Stone
# @raycast.authorURL https://github.com/adamstone-io
# @raycast.description Pastes a timestamp at cursor location.

# Generate timestamp 
timestamp=$(date -u +"%Y%m%d%H%M%S")


# The text to paste
text_to_paste="${timestamp}"

# Use AppleScript to type the text at the cursor
osascript <<EOF
tell application "System Events"
    keystroke "$text_to_paste"
end tell
EOF