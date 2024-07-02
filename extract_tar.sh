#!/bin/bash

# Make sure script is executable
# chmod +x extract_tar.sh

# Provide directory to .tar files as first argument
# Script will extract files to a directory with the same name as the .tar file
# If the contents of the .tar file are .gz files, will gunzip those as well

# Check if directory is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Set the target directory
TARGET_DIR="$1"

# Find all .tar files in the target directory
find "$TARGET_DIR" -type f -name "*.tar" | while read tarfile; do
  # Get the directory name by stripping the .tar extension
  dirname="${tarfile%.tar}"

  # Create the directory if it doesn't exist
  mkdir -p "$dirname"

  # Untar the file into the directory
  tar -xvf "$tarfile" -C "$dirname"

  # Remove the .tar file if desired (uncomment the next line)
  # rm "$tarfile"

  # Find all .gz files in the extracted directory
  find "$dirname" -type f -name "*.gz" | while read gzfile; do
    # Unzip the .gz file
    gunzip "$gzfile"
  done
done

