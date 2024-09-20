### Libraries ###
library(tidyverse)
library(here)
library(googledrive)

### Input ### 

# File URL with direct download
business_dataset <- 'https://drive.google.com/uc?export=download&id=12o5mGJV8ck_Kqi_x23WF1HbsNGIP70ru'
user_dataset <- 'https://drive.google.com/uc?export=download&id=1g-Sy1IMEqrPtPtcc1t2U78iR9Eh8EMtC'
review_dataset <- 'https://drive.google.com/uc?export=download&id=1nlI5cioa3Q6uZhzEdD5ZvXq_FlvsM1wL'

# Temporary file to save the download
temp_business <- tempfile(fileext = ".csv")
temp_user <- tempfile(fileext = ".csv")
temp_review <- tempfile(fileext = ".csv")

# Download the files
download.file(business_dataset, destfile = temp_business, mode = "wb")
download.file(user_dataset, destfile = temp_user, mode = "wb")
download.file(review_dataset, destfile = temp_review, mode = "wb")

# Load the CSV files into variables
business_data <- read_csv(temp_business)
user_data <- read_csv(temp_user)
review_data <- read_csv(temp_review)

# View the first few rows
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
