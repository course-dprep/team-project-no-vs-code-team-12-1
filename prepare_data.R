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

### Transforming ###

# Inspecting the data
str(business_data) 
str(user_data)
str(review_data)


# Selecting variables/columns of interest
business_data <- business_data %>% 
  select(business_id, name, state, city, stars, review_count, is_open,
         attributes)

user_data <- user_data %>% 
  select(user_id, review_count, fans, elite)

review_data <- review_data %>% 
  select(review_id, user_id, business_id, stars)

# Combining the data
merge1 <- left_join(user_data, review_data, by = "user_id")

merged_data <- left_join(merge1, business_data, by = "business_id")

# Take sample of 50.000

set.seed(90)
sample_data <- merged_data %>% 
  slice_sample(n = 50000)


### Output ###

# Write csv file
write_csv(sample_data, "sample_data.csv")
