# Set up
library(tidyverse)
library(dplyr)

# Load data
data <- read_csv('cleaned_sample_data.csv')
head(data)
summary(data)

# Transformation
colnames(data)

# Check the unique values in the 'elite' column
unique_elite_values <- unique(data$elite)
print(unique_elite_values)

# Ensure that the 'elite' column is of character type
data$elite <- as.character(data$elite)

# Create 'elite_label_encoder' column:
# - If 'elite' is "nan", then set to 0 (non-influential user)
# - Otherwise, set to 1 (influential user)

data$elite_label_encoder <- ifelse(data$elite == "nan", 0, 1)

num_non_influential <- sum(data$elite_label_encoder == 0)
cat("Number of non-influential users (elite_label_encoder == 0):", num_non_influential, "\n")

num_influential <- sum(data$elite_label_encoder == 1)
cat("Number of non-influential users (elite_label_encoder == 1):", num_influential, "\n")

# Remove the 'elite' column from the data frame
data$elite <- NULL

# Save the data frame
write.csv(data, "sample_data_final.csv", row.names = FALSE)
