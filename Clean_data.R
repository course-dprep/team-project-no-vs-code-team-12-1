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

# Change user to elite users indicated by 1 and non-elite users indicated by 0
sample_data <- sample_data %>%
  mutate(elite_user = if_else(is.na(elite), 0, 1))

# Check elite_user variable
sample_data$elite_user


# check attributes variable
unique(sample_data$attributes)

# Remove NA's in attributes data
sample_data <- sample_data %>% 
  filter(!is.na(attributes))

# Select only the take-out restaurants
takeout_data <- sample_data %>%
  filter(str_detect(attributes, "'RestaurantsTakeOut'\\s*:\\s*'True'"))

### Output ###
write_csv(takeout_data, here("Data", "takeout_data.csv"))
