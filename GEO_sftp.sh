#!/bin/bash

### Script to download files from GEO, run in the target directory
# Prompt user for input
echo "Enter a valid GEO Series Accession (GSE#####):"

# Read input store as variable
read GEO_ACC

# Function to check if a URL is valid
check_url() {
  if curl --output /dev/null --silent --head --fail "$1"; then
    return 0
  else
    return 1
  fi
}

# Check for a valid GSE accession number
url_to_check="https://ftp.ncbi.nlm.nih.gov/geo/series/${GEO_ACC:0:6}nnn/$GEO_ACC/"

# Check if the URL is valid
if check_url "$url_to_check"; then
  echo "GSE is valid. Continuing..."
  # Create a directory to store the downloaded data
  #mkdir -p $GEO_ACC
  #cd $GEO_ACC

  # Download the dataset using wget
  wget -r -np -nH --cut-dirs=3 -R "index.html*" ftp://ftp.ncbi.nlm.nih.gov/geo/series/${GEO_ACC:0:6}nnn/$GEO_ACC/

  echo "Download complete. Files are in the $GEO_ACC directory."
else
  echo "GSE is not valid."
fi
