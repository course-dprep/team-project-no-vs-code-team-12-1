# Install the archive package
install.packages("archive")

# Load the archive package
library(archive)
library(tidyverse)

# Specify the path to your .rar file
rar_file <- "yelp_dataset.tar"

# Verify if R can see the file
file.exists(rar_file)

# List the contents of the .rar file
contents <- archive::archive(rar_file)
print(contents)

# Specify the extraction directory (make sure it is a directory)
extract_dir <- "extracted_files"

# Create the directory if it doesn't exist
if (!dir.exists(extract_dir)) {
  dir.create(extract_dir)
}

# Extract the files
extracted_files <- archive::archive_extract(rar_file, dir = extract_dir)
print(extracted_files)