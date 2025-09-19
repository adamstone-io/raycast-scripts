#!/usr/bin/env python3
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Process Markdown from Clipboard
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 📋
#
# Documentation:    
# @raycast.author Adam Stone
# @raycast.authorURL https://github.com/adamstone-io
# @raycast.description Splits #### Headings into notes, timestamps each title (in filenames), saves files to output directory, and copies a list of file titles to the clipboard each file name wrapped in [[]].
# @raycast.author Your Name

import subprocess
import os
import re
from datetime import datetime

# Set your output directory here
OUTPUT_DIR = "/PATH/TO/YOUR/VAULT/"

def get_clipboard():
    return subprocess.run("pbpaste", capture_output=True, text=True).stdout

def set_clipboard(text):
    p = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
    p.communicate(input=text.encode('utf-8'))

def parse_sections(content):
    """
    Parses the content into a list of tuples (title, content).
    Assumes titles are lines starting with '#### '.
    """
    pattern = r'(#### .+?)(?=#### |\Z)'
    matches = re.findall(pattern, content, flags=re.DOTALL)
    sections = []
    for match in matches:
        lines = match.strip().split('\n')
        title = lines[0][5:].strip()  # Remove '#### ' prefix
        section_content = '\n'.join(lines[1:]).strip()
        sections.append((title, section_content))
    return sections

def add_timestamps_to_sections(sections):
    """
    Adds a timestamp to each section tuple.
    Returns a list of tuples containing (title, content, timestamp).
    """
    timestamp_format = "%Y%m%d%H%M%S"
    timestamped_sections = []
    for title, content in sections:
        timestamp = datetime.now().strftime(timestamp_format)
        timestamped_sections.append((title, content, timestamp))
    return timestamped_sections

def file_names_and_links(timestamped_sections):
    """
    Generates a list of file names and obsidian links using the timestamp and title from each section.

    Obsidian links are formateed as: [[timestamp title]]
    Filenames are formatted as 'YYYYMMDDHHMMSS title.md'.    
    
    Args:
        timestamped_sections: List of tuples (title, content, timestamp)
    
    Returns:
        List of filenames as strings
        List of Obsidian links as strings
    """
    filenames = []
    obsidian_links = []
    for title, _, timestamp in timestamped_sections:
        # Replace any invalid filename characters in the title
        safe_title = re.sub(r'[<>:"/\\|?*]', '_', title)
        
        filename = f"{timestamp} {safe_title}.md"
        obsidian_link = f"[[{timestamp} {safe_title}]]"
        
        filenames.append(filename)
        obsidian_links.append(obsidian_link)
    
    return filenames, obsidian_links

def write_sections_to_files(timestamped_sections, filenames):
    """
    Writes each section's content to its corresponding markdown file.
    Includes date header and Links & References section.
    
    Args:
        timestamped_sections: List of tuples (title, content, timestamp)
        filenames: List of filenames for each section
    """
    current_date = datetime.now().strftime("%d-%m-%Y")
    
    for (_, content, _), filename in zip(timestamped_sections, filenames):
        filepath = os.path.join(OUTPUT_DIR, filename)
        formatted_content = f"""{content}
#### Links & References"""
       
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(formatted_content)
       

def copy_links_to_clipboard(obsidian_links):
    """
    Copies all Obsidian links to clipboard, each on a new line.
    
    Args:
        obsidian_links: List of Obsidian link strings
    """
    links_text = '\n'.join(obsidian_links)
    set_clipboard(links_text)


def main():
    # Get clipboard content
    content = get_clipboard()

    # Parse sections from the content
    sections = parse_sections(content)

    # Add timestamps to sections
    timestamped_sections = add_timestamps_to_sections(sections)
    
    # Generate filenames and links
    filenames, obsidian_links = file_names_and_links(timestamped_sections)
    
    # Write sections to files
    write_sections_to_files(timestamped_sections, filenames)
    
    # Copy links to clipboard
    copy_links_to_clipboard(obsidian_links)
    
if __name__ == '__main__':
    main()