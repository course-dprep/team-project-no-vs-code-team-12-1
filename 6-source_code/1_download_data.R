### Libraries ###
library(tidyverse)
library(here)
library(googledrive)

### Authentication ###

drive_auth()

### Input ### 

# File ID from Google Drive URLs
business_file_id <- '12o5mGJV8ck_Kqi_x23WF1HbsNGIP70ru'
user_file_id <- '1g-Sy1IMEqrPtPtcc1t2U78iR9Eh8EMtC'
review_file_id <- '1U5rSviYm-EfCxx23EiIAYqNH2JwHp3DT'

# Paths to save the files in the working directory
business_file <- here("2-temporary_data", "business_data.csv")
user_file <- here("2-temporary_data", "user_data.csv")
review_file <- here("2-temporary_data", "review_data.csv")

# Download files using googledrive package
drive_download(as_id(business_file_id), path = business_file, overwrite = TRUE)
drive_download(as_id(user_file_id), path = user_file, overwrite = TRUE)
drive_download(as_id(review_file_id), path = review_file, overwrite = TRUE)

# Load the CSV files into variables
business_data <- read_csv(business_file)
user_data <- read_csv(user_file)
review_data <- read_csv(review_file)

# View the first few rows
head(business_data)
head(user_data)
head(review_data)