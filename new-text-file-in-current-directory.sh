#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Text file - Current Directory
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Create a new text file in the current directory

# Use AppleScript to get the current Finder directory
CURRENT_DIR=$(osascript -e '
tell application "Finder"
    if (count of Finder windows) > 0 then
        set currentFolder to (target of front Finder window as alias)
        POSIX path of currentFolder
    else
        POSIX path of (path to desktop)
    end if
end tell
')

# Define the file name
FILE_NAME="NewFile.txt"

# Construct the full file path
FILE_PATH="${CURRENT_DIR}${FILE_NAME}"

# Check if the file already exists and create a unique name if necessary
COUNTER=1
while [ -f "$FILE_PATH" ]; do
  FILE_PATH="${CURRENT_DIR}NewFile-$(printf "%02d" $COUNTER).txt"
  COUNTER=$((COUNTER + 1))
done

# Create the new file
touch "$FILE_PATH"
echo "Created: $FILE_PATH"

# Open the file in the default text editor (or specify VS Code)
open -e "$FILE_PATH"  # Replace `-e` with `-a "Visual Studio Code"` to use VS Code
