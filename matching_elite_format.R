### Libraries ###
library(tidyverse)
library(here)

# Load the sample dataset
df_sample <- read.csv('sample_data.csv')

# Load the population dataset
df_population <- read.csv('yelp_academic_dataset_user.csv')

# Keep only 'user_id' and 'elite' columns in df_population
df_population_filtered <- df_population[, c('user_id', 'elite')]

# Check 'elite' column in df_population_filtered
df_population_filtered[!is.na(df_population_filtered$elite), "elite"]

# Convert all values in the 'elite' column to strings
df_population_filtered$elite <- as.character(df_population_filtered$elite)


# Perform a left join between df_sample and df_population_filtered based on 'user_id'
df_merged <- merge(df_sample, df_population_filtered, by = 'user_id', all.x = TRUE)

# Remove the 'elite_x' column and rename 'elite_y' to 'elite'
df_merged_cleaned <- df_merged
if ("elite.x" %in% colnames(df_merged_cleaned) & "elite.y" %in% colnames(df_merged_cleaned)) {
  df_merged_cleaned$elite <- df_merged_cleaned$elite.y  # Copy 'elite.y' to 'elite'
  df_merged_cleaned <- df_merged_cleaned[, !colnames(df_merged_cleaned) %in% c("elite.x", "elite.y")]  # Remove 'elite.x' and 'elite.y'
}

# Filter rows where the 'elite' column is not null
df_merged_cleaned_non_null <- df_merged_cleaned[!is.na(df_merged_cleaned$elite), ]

# Convert all values in the 'elite' column to strings
df_merged_cleaned$elite <- as.character(df_merged_cleaned$elite)

# Display non-null (non-NA) values of the 'elite' column
non_null_elite <- df_merged_cleaned[!is.na(df_merged_cleaned$elite), "elite"]

# Show the non-null values
print(non_null_elite)

# Save the cleaned dataframe to a CSV file
write.csv(df_merged_cleaned, 'cleaned_sample_data.csv', row.names = FALSE)
