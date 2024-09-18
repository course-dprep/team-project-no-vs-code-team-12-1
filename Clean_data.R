### Libraries ###

library(tidyverse)
library(here)

### Input ###

sample_data <- read_csv(here('data', 'sample_data.csv'))

### Transformation ###

# Inspect column names of the data
colnames(sample_data)

# Change column names
sample_data <- sample_data %>% 
  rename(stars_user = stars.x,
         stars_business = stars.y,
         review_count_user = review_count.x,
         review_count_business = review_count.y,
         username = name)


# Check changes
colnames(sample_data)

# Check for NA's in the data
variable_na <- sample_data %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(cols = everything(), 
               names_to = "variable", values_to = "na_count")

View(variable_na)

# Check elite variable
unique(sample_data$elite)

# Split the years in the elite variable

###### !!! Needs to be added !!! ########

# check attributes variable
unique(sample_data$attributes)

# Remove NA's in attributes data
sample_data <- sample_data %>% 
  filter(!is.na(attributes))

# Create variable that shows if a review is a "elite review"

###### !!! Needs to be added !!! ########

# Select only the take-out restaurants
takeout_data <- sample_data %>%
  filter(str_detect(attributes, "'RestaurantsTakeOut'\\s*:\\s*'True'"))


### Output ###
#write_csv(takeout_data, here("data", "takeout_data.csv"))
