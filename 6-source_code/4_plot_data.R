### Libraries ###
library(tidyverse)
library(here)
library(dplyr)
library(ggcorrplot)
library(ggplot2)

### Input ###

takeout_data <- read_csv(here('3-final_data', 'takeout_data.csv'))
head(takeout_data)

# Inspect column names of the data
colnames(takeout_data)

# Display the structure of the data
glimpse(takeout_data)

# Summary statistics for numeric variables
summary(select(takeout_data,where(is.numeric)))

# check for missing values
missing_values <- takeout_data %>%
  summarize_all(~sum(is.na(.)))
print(missing_values)

# Distribution of User Ratings by Elite Review Status
rating_distribution_plot <- ggplot(takeout_data, aes(x = stars_user, fill = factor(elite_review))) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of User Ratings by Elite Review Status", x = "User Rating", y = "Count", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/distribution_user_ratings_by_elite_review.png", plot = rating_distribution_plot, width = 8, height = 6)

# Average rating by division
avg_rating_division <- takeout_data %>%
  group_by(division, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot the average user rating by division with elite review status
avg_rating_division_plot <- ggplot(avg_rating_division, aes(x = reorder(division, -avg_rating), y = avg_rating, fill = factor(elite_review))) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating by Division and Elite Review Status", x = "Division", y = "Average User Rating", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/user_ratings_by_division_elite_review.png", plot = avg_rating_division_plot, width = 12, height = 8)

# Distribution of review count by business with is_open as a condition, using distinct colors
review_count_histogram_open <- ggplot(takeout_data, aes(x = review_count_business, fill = factor(is_open))) +
  geom_histogram(binwidth = 50, color = "black", position = "stack") +
  labs(title = "Distribution of Review Count by Business (Open vs. Closed)", x = "Review Count", y = "Frequency", fill = "Is Open") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("0" = "orange", "1" = "green"), labels = c("Closed", "Open"))

# Save the plot
ggsave("7-plots/distribution_review_count_business_by_is_open.png", plot = review_count_histogram_open, width = 8, height = 6)

# Filter data for businesses with review count > 1000
data_gt_1000_division <- takeout_data %>%
  filter(review_count_business > 1000) %>%
  group_by(division, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot average user rating by division for both elite and non-elite groups
avg_rating_gt_1000_division_plot <- ggplot(data_gt_1000_division, aes(x = reorder(division, -avg_rating), y = avg_rating, fill = factor(elite_review))) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating of Business with Review Count > 1000 by Division (Elite vs. Non-Elite)", x = "Division", y = "Average User Rating", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_gt_1000_by_division.png", plot = avg_rating_gt_1000_division_plot, width = 10, height = 6)

# Filter data for businesses with review count < 1000
data_lt_1000_division <- takeout_data %>%
  filter(review_count_business < 1000) %>%
  group_by(division, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot average user rating by division for both elite and non-elite groups
avg_rating_lt_1000_division_plot <- ggplot(data_lt_1000_division, aes(x = reorder(division, -avg_rating), y = avg_rating, fill = factor(elite_review))) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating of Business with Review Count < 1000 by Division (Elite vs. Non-Elite)", x = "Division", y = "Average User Rating", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_lt_1000_by_division.png", plot = avg_rating_lt_1000_division_plot, width = 10, height = 6)

# Filter data for businesses with review count > 1000
data_gt_1000_is_open <- takeout_data %>%
  filter(review_count_business > 1000) %>%
  group_by(is_open, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot average user rating by is_open for both elite and non-elite groups
avg_rating_gt_1000_is_open_plot <- ggplot(data_gt_1000_is_open, aes(x = factor(is_open), y = avg_rating, fill = factor(elite_review))) +
  geom_col(position = "dodge") +
  labs(title = "Average User Rating of Business with Review Count > 1000 by Is_Open (Elite vs. Non-Elite)", x = "Is Open", y = "Average User Rating", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_gt_1000_by_is_open.png", plot = avg_rating_gt_1000_is_open_plot, width = 8, height = 6)

# Filter data for businesses with review count < 1000
data_lt_1000_is_open <- takeout_data %>%
  filter(review_count_business < 1000) %>%
  group_by(is_open, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot average user rating by is_open for both elite and non-elite groups
avg_rating_lt_1000_is_open_plot <- ggplot(data_lt_1000_is_open, aes(x = factor(is_open), y = avg_rating, fill = factor(elite_review))) +
  geom_col(position = "dodge") +
  labs(title = "Average User Rating of Business with Review Count < 1000 by Is_Open (Elite vs. Non-Elite)", x = "Is Open", y = "Average User Rating", fill = "Elite Review") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_lt_1000_by_is_open.png", plot = avg_rating_lt_1000_is_open_plot, width = 8, height = 6)

# Filter data for take-out restaurants and calculate average rating by elite status
avg_rating_elite <- takeout_data %>%
  filter(take_out == 1) %>%
  group_by(elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot average rating by elite status
avg_rating_elite_plot <- ggplot(avg_rating_elite, aes(x = factor(elite_review), y = avg_rating, fill = factor(elite_review))) +
  geom_col() +
  labs(title = "Average User Rating for Take-Out Restaurants by Elite Status", x = "User Type (0 = Non-Elite, 1 = Elite)", y = "Average Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_takeout_by_elite_status.png", plot = avg_rating_elite_plot, width = 8, height = 6)

# Filter data for take-out restaurants and calculate average rating by elite status and division
avg_rating_elite_division <- takeout_data %>%
  filter(take_out == 1) %>%
  group_by(division, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

# Plot boxplot for user ratings by elite status and division
boxplot_elite_division <- ggplot(takeout_data %>% filter(take_out == 1), aes(x = reorder(division, -stars_user), y = stars_user, fill = factor(elite_review))) +
  geom_boxplot() +
  coord_flip() +
  labs(title = "Distribution of User Ratings for Take-Out Restaurants by Division and Elite Status", x = "Division", y = "User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/distribution_ratings_takeout_by_division_and_elite_status.png", plot = boxplot_elite_division, width = 10, height = 6)

# Plot boxplot for user ratings by elite status
boxplot_elite <- ggplot(takeout_data %>% filter(take_out == 1), aes(x = factor(elite_review), y = stars_user, fill = factor(elite_review))) +
  geom_boxplot() +
  labs(title = "Distribution of User Ratings for Take-Out Restaurants by Elite Status", x = "Elite Status (0 = Non-Elite, 1 = Elite)", y = "User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/distribution_ratings_takeout_by_elite_status.png", plot = boxplot_elite, width = 8, height = 6)

# Compute correlation for numerical columns
numeric_cols <- takeout_data %>%
  select(where(is.numeric))

cor_matrix <- cor(numeric_cols, use = "complete.obs")
print(cor_matrix)

# Visualize correlation matrix with a heatmap, centralizing the title
correlation_plot <- ggcorrplot(cor_matrix, lab = TRUE) +
  labs(title = "Correlation Matrix Heatmap") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/correlation_matrix_heatmap.png", plot = correlation_plot, width = 10, height = 8)

# Scatterplot for relationship between number of fans and user rating, color-coded by open status and faceted by division
scatter_fans_rating_plot <- ggplot(takeout_data, aes(x = fans, y = stars_user, color = factor(is_open))) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ division, scales = "free") +
  labs(title = "Relationship Between Number of Fans and User Rating, Faceted by Division and Colored by Business Open Status", x = "Number of Fans", y = "User Rating", color = "Is Open") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/relationship_fans_user_rating_faceted_by_division.png", plot = scatter_fans_rating_plot, width = 12, height = 8)