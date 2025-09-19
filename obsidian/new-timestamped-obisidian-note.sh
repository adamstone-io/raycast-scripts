#!/bin/zsh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Timestamped Obsidian Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon obsidian-icon.png
# @raycast.packageName Obsidian

# Documentation:
# @raycast.author Adam Stone
# @raycast.authorURL https://github.com/adamstone-io
# @raycast.description Creates a note, deselects the title, and adds a trailing space, moves cursor to the far right.

# --- CONFIGURATION ---
# This script reads its configuration from an environment variable.
# To set it, open your shell profile (e.g., ~/.zshrc) and add:
# export OBSIDIAN_VAULT_NAME="Your Vault Name"
# Then, restart Raycast.

source ~/.zshrc

if [ -z "$OBSIDIAN_VAULT_NAME" ]; then
    echo "Error: The OBSIDIAN_VAULT_NAME environment variable is not set."
    echo "Please set it in your shell profile (e.g., ~/.zshrc) and restart Raycast."
    exit 1
fi

# Set the vault name from the environment variable.
VAULT_NAME="$OBSIDIAN_VAULT_NAME"
# --- END CONFIGURATION ---

# Generate the timestamp in the format YYYYMMDDHHMMSS.
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# URL-encode the timestamp to use as the note name.
ENCODED_NAME=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$TIMESTAMP'''))")

# Construct the final deeplink.
DEEPLINK="obsidian://new?vault=$VAULT_NAME&name=$ENCODED_NAME"

# Open the deeplink to create the note.
open "$DEEPLINK"

# --- UI SCRIPTING ---
# Use AppleScript to wait for Obsidian and then send keystrokes.
osascript <<EOD
tell application "Obsidian"
    activate
end tell

delay 0.1

tell application "System Events"
    -- 1. Press Right Arrow key to deselect the title and move the cursor to the end.
    key code 124
    -- 2. Press the Spacebar to type a space.
    key code 49
end tell
EOD
