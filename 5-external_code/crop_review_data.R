# Libraries
library(tidyverse)
library(here)

# Input
reviews <- read_csv(here("Data", "yelp_academic_dataset_review.csv"))

# Data Preparation
set.seed(90)

reduced_reviews <- slice_sample(reviews, n = 500000)

# Output
write_csv(reduced_reviews, here("Data", "yelp_academic_dataset_reviews_reduced.csv"))


