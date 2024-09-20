### Libraries ###
library(tidyverse)
library(here)
library(googledrive)

### Input ### 

# File ID from Google Drive URLs
business_file_id <- '12o5mGJV8ck_Kqi_x23WF1HbsNGIP70ru'
user_file_id <- '1g-Sy1IMEqrPtPtcc1t2U78iR9Eh8EMtC'
review_file_id <- '1nlI5cioa3Q6uZhzEdD5ZvXq_FlvsM1wL'

# Paths to save the files in the working directory
business_file <- "business_data.csv"
user_file <- "user_data.csv"
review_file <- "review_data.csv"

# Download files using googledrive package
drive_download(as_id(business_file_id), path = business_file, overwrite = TRUE)
drive_download(as_id(user_file_id), path = user_file, overwrite = TRUE)
drive_download(as_id(review_file_id), path = review_file, overwrite = TRUE)

# Load the CSV files into variables
business_data <- read_csv(business_file)
user_data <- read_csv(user_file)
review_data <- read_csv(review_file)

# Optional: View the first few rows
head(business_data)
head(user_data)
head(review_data)