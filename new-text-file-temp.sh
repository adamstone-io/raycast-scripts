#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Text file - Temp
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Create a txt file in the temp folder
# @raycast.author Raycast
# @raycast.authorURL https://raycast.com

# Define the base file path and folder
FOLDER="/temp/directory"
BASE_NAME="NewNote"
EXTENSION=".txt"

# Start with the base file name
FILE_PATH="$FOLDER/$BASE_NAME$EXTENSION"
COUNTER=1

# Check if the file exists, and if it does, increment the counter
while [ -f "$FILE_PATH" ]; do
  FILE_PATH="$FOLDER/$BASE_NAME-$(printf "%02d" $COUNTER)$EXTENSION"
  COUNTER=$((COUNTER + 1))
done

# Create the new file
touch "$FILE_PATH"
echo "Created: $FILE_PATH"

# Open the file in VS Code
code "$FILE_PATH"
