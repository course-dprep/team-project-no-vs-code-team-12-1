### Libraries ###
library(tidyverse)
library(here)

### Input ### 

# Loading in data files
business_data <- read_csv(here("Data", "yelp_academic_dataset_business.csv"))
user_data <- read_csv(here("Data", "yelp_academic_dataset_user.csv"))
review_data <- read_csv(here("Data", "yelp_academic_dataset_review.csv"))


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