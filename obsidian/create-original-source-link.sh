#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Original Source Link
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Adam Stone
# @raycast.authorURL https://github.com/adamstone-io
# @raycast.description Creates an internal link to a timestamped note which has 'Original Source' in the title. 

# Generate timestamp
timestamp=$(date -u +"%Y%m%d%H%M%S")

# Your custom source text
original_source="Original Source"

# The text to paste
text_to_paste="[[${timestamp} ${original_source}]]"

# Use AppleScript to type the text at the cursor
osascript <<EOF
tell application "System Events"
    keystroke "$text_to_paste"
end tell
EOF
