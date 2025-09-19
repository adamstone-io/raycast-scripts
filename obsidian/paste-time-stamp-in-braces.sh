#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste timestamp in [[ ]]
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Adam Stone
# @raycast.authorURL https://github.com/adamstone-io
# @raycast.description Pastes an internal link with a timestamp in it.

# Generate timestamp
timestamp=$(date -u +"%Y%m%d%H%M%S ")


# The text to paste
text_to_paste="[[${timestamp}]]"

# Use AppleScript to type the text at the cursor
osascript <<EOF
tell application "System Events"
    keystroke "$text_to_paste"
    repeat 2 times
        key code 123
    end repeat
end tell
EOF
