### Libraries ###
library(tidyverse)
library(here)
library(dplyr)
library(ggcorrplot)
library(ggplot2)

### Input ###

takeout_data <- read_csv(here('3-final_data', 'takeout_data.csv'))

# Convert 'elite_review' to a factor with labels "No" and "Yes"
takeout_data <- takeout_data %>%
  mutate(elite_review = factor(elite_review, levels = c(0, 1), labels = c("No", "Yes")))

#------------------------------------------
# Plot 1: Distribution of User Ratings by Elite Status
#------------------------------------------

rating_distribution_plot <- ggplot(takeout_data, aes(x = stars_user, fill = elite_review)) +
  geom_bar(position = "dodge") +
  labs(title = "Distribution of User Ratings by Elite Status",
       x = "User Rating", y = "Count", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/distribution_user_ratings_by_elite_review.png", plot = rating_distribution_plot, width = 8, height = 6)

#------------------------------------------
# Plot 2: Distribution of User Ratings for Take-Out Restaurants by Elite Status
#------------------------------------------

boxplot_elite <- ggplot(takeout_data %>% filter(take_out == 1), aes(x = elite_review, y = stars_user, fill = elite_review)) +
  geom_boxplot() +
  labs(title = "Distribution of User Ratings for Take-Out Restaurants by Elite Status",
       x = "Elite Status", y = "User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/distribution_ratings_takeout_by_elite_review.png", plot = boxplot_elite, width = 8, height = 6)

#------------------------------------------
# Plot 3: Average User Rating by Region and Elite Status
#------------------------------------------

avg_rating_region <- takeout_data %>%
  group_by(region, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

avg_rating_region_plot <- ggplot(avg_rating_region, aes(x = reorder(region, -avg_rating), y = avg_rating, fill = elite_review)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating by Region and Elite Status",
       x = "Region", y = "Average User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/user_ratings_by_region_elite_review.png", plot = avg_rating_region_plot, width = 12, height = 8)

#------------------------------------------
# Plot 4: Distribution of Review Count by Business Open Status
#------------------------------------------

review_count_histogram_open <- ggplot(takeout_data, aes(x = review_count_business, fill = factor(is_open))) +
  geom_histogram(binwidth = 50, color = "black", position = "stack") +
  labs(title = "Distribution of Review Count by Business (Open vs. Closed)",
       x = "Review Count", y = "Frequency", fill = "Is Open") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_fill_manual(values = c("0" = "orange", "1" = "green"), labels = c("Closed", "Open"))

# Save the plot
ggsave("7-plots/distribution_review_count_business_by_is_open.png", plot = review_count_histogram_open, width = 8, height = 6)

#------------------------------------------
# Plot 5: Average User Rating of Businesses with Review Count > 1000 by Region and Elite Status
#------------------------------------------

data_gt_1000_region <- takeout_data %>%
  filter(review_count_business > 1000) %>%
  group_by(region, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

avg_rating_gt_1000_region_plot <- ggplot(data_gt_1000_region, aes(x = reorder(region, -avg_rating), y = avg_rating, fill = elite_review)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating of Businesses with Review Count > 1000 by Region and Elite Status",
       x = "Region", y = "Average User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_gt_1000_by_region.png", plot = avg_rating_gt_1000_region_plot, width = 10, height = 6)

#------------------------------------------
# Plot 6: Average User Rating of Businesses with Review Count > 1000 by Open Status and Elite Status
#------------------------------------------

data_gt_1000_is_open <- takeout_data %>%
  filter(review_count_business > 1000) %>%
  group_by(is_open, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

avg_rating_gt_1000_is_open_plot <- ggplot(data_gt_1000_is_open, aes(x = factor(is_open), y = avg_rating, fill = elite_review)) +
  geom_col(position = "dodge") +
  labs(title = "Average User Rating of Businesses with Review Count > 1000 by Open Status and Elite Status",
       x = "Is Open", y = "Average User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_discrete(labels = c("0" = "Closed", "1" = "Open"))

# Save the plot
ggsave("7-plots/avg_rating_gt_1000_by_is_open.png", plot = avg_rating_gt_1000_is_open_plot, width = 8, height = 6)

#------------------------------------------
# Plot 7: Average User Rating of Businesses with Review Count < 1000 by Region and Elite Status
#------------------------------------------

data_lt_1000_region <- takeout_data %>%
  filter(review_count_business < 1000) %>%
  group_by(region, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

avg_rating_lt_1000_region_plot <- ggplot(data_lt_1000_region, aes(x = reorder(region, -avg_rating), y = avg_rating, fill = elite_review)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(title = "Average User Rating of Businesses with Review Count < 1000 by Region and Elite Status",
       x = "Region", y = "Average User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5))

# Save the plot
ggsave("7-plots/avg_rating_lt_1000_by_region.png", plot = avg_rating_lt_1000_region_plot, width = 10, height = 6)

#------------------------------------------
# Plot 8: Average User Rating of Businesses with Review Count < 1000 by Open Status and Elite Status
#------------------------------------------

data_lt_1000_is_open <- takeout_data %>%
  filter(review_count_business < 1000) %>%
  group_by(is_open, elite_review) %>%
  summarise(avg_rating = mean(stars_user, na.rm = TRUE)) %>%
  ungroup()

avg_rating_lt_1000_is_open_plot <- ggplot(data_lt_1000_is_open, aes(x = factor(is_open), y = avg_rating, fill = elite_review)) +
  geom_col(position = "dodge") +
  labs(title = "Average User Rating of Businesses with Review Count < 1000 by Open Status and Elite Status",
       x = "Is Open", y = "Average User Rating", fill = "Elite Status") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_discrete(labels = c("0" = "Closed", "1" = "Open"))

# Save the plot
ggsave("7-plots/avg_rating_lt_1000_by_is_open.png", plot = avg_rating_lt_1000_is_open_plot, width = 8, height = 6)

#------------------------------------------
# Plot 9: Relationship Between Number of Fans and User Rating by Region and Open Status
#------------------------------------------

scatter_fans_rating_plot <- ggplot(takeout_data, aes(x = fans, y = stars_user, color = factor(is_open))) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  facet_wrap(~ region, scales = "free") +
  labs(title = "Relationship Between Number of Fans and User Rating by Region and Open Status",
       x = "Number of Fans", y = "User Rating", color = "Is Open") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_color_manual(values = c("0" = "orange", "1" = "green"), labels = c("Closed", "Open"))

# Save the plot
ggsave("7-plots/relationship_fans_user_rating_faceted_by_region.png", plot = scatter_fans_rating_plot, width = 12, height = 8)