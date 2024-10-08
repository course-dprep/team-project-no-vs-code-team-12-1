### Libraries ###
library(tidyverse)
library(here)
library(ggplot2)

### Input ###

sample_data <- read_csv(here('2-temporary_data', 'sample_data.csv'))

### Transformation ###

# Inspect column names of the data
colnames(sample_data)

# Change column names
sample_data <- sample_data %>% 
  rename(
    stars_user = stars.x,
    stars_business = stars.y,
    review_count_user = review_count.x,
    review_count_business = review_count.y,
    username = name
  )

# Change user to elite users indicated by 1 and non-elite users indicated by 0
sample_data <- sample_data %>%
  mutate(elite_review = if_else(is.na(elite), 0, 1))

# Remove elite column
sample_data <- sample_data %>% select(-elite)

# Create new division variable

# Step 1: Define the state_divisions vector
state_divisions <- c(
  # New England
  'CT' = 'New England',
  'ME' = 'New England',
  'MA' = 'New England',
  'NH' = 'New England',
  'RI' = 'New England',
  'VT' = 'New England',
  
  # Middle Atlantic
  'NJ' = 'Middle Atlantic',
  'NY' = 'Middle Atlantic',
  'PA' = 'Middle Atlantic',
  
  # East North Central
  'IL' = 'East North Central',
  'IN' = 'East North Central',
  'MI' = 'East North Central',
  'OH' = 'East North Central',
  'WI' = 'East North Central',
  
  # West North Central
  'IA' = 'West North Central',
  'KS' = 'West North Central',
  'MN' = 'West North Central',
  'MO' = 'West North Central',
  'NE' = 'West North Central',
  'ND' = 'West North Central',
  'SD' = 'West North Central',
  
  # South Atlantic
  'DE' = 'South Atlantic',
  'DC' = 'South Atlantic',
  'FL' = 'South Atlantic',
  'GA' = 'South Atlantic',
  'MD' = 'South Atlantic',
  'NC' = 'South Atlantic',
  'SC' = 'South Atlantic',
  'VA' = 'South Atlantic',
  'WV' = 'South Atlantic',
  
  # East South Central
  'AB' = 'East South Central',
  'KY' = 'East South Central',
  'MS' = 'East South Central',
  'TN' = 'East South Central',
  
  # West South Central
  'AR' = 'West South Central',
  'LA' = 'West South Central',
  'OK' = 'West South Central',
  'TX' = 'West South Central',
  
  # Mountain
  'AZ' = 'Mountain',
  'CO' = 'Mountain',
  'ID' = 'Mountain',
  'MT' = 'Mountain',
  'NV' = 'Mountain',
  'NM' = 'Mountain',
  'UT' = 'Mountain',
  'WY' = 'Mountain',
  
  # Pacific
  'AK' = 'Pacific',
  'CA' = 'Pacific',
  'HI' = 'Pacific',
  'OR' = 'Pacific',
  'WA' = 'Pacific'
)

# Step 2: Map the states to divisions
sample_data <- sample_data %>%
  mutate(division = state_divisions[state])

# Check NA
na_div <- sample_data %>% 
  filter(is.na(division))
na_div

# Remove NA
sample_data <- sample_data %>% 
  filter(!is.na(division))

# Create new region variable

# Step 1: Define the region vector
state_regions <- c(
  # Northeast
  'CT' = 'Northeast',
  'ME' = 'Northeast',
  'MA' = 'Northeast',
  'NH' = 'Northeast',
  'NJ' = 'Northeast',
  'NY' = 'Northeast',
  'PA' = 'Northeast',
  'RI' = 'Northeast',
  'VT' = 'Northeast',
  
  # Midwest
  'IL' = 'Midwest',
  'IN' = 'Midwest',
  'IA' = 'Midwest',
  'KS' = 'Midwest',
  'MI' = 'Midwest',
  'MN' = 'Midwest',
  'MO' = 'Midwest',
  'NE' = 'Midwest',
  'ND' = 'Midwest',
  'OH' = 'Midwest',
  'SD' = 'Midwest',
  'WI' = 'Midwest',
  
  # South
  'AB' = 'South',
  'AR' = 'South',
  'DE' = 'South',
  'DC' = 'South',
  'FL' = 'South',
  'GA' = 'South',
  'KY' = 'South',
  'LA' = 'South',
  'MD' = 'South',
  'MS' = 'South',
  'NC' = 'South',
  'OK' = 'South',
  'SC' = 'South',
  'TN' = 'South',
  'TX' = 'South',
  'VA' = 'South',
  'WV' = 'South',
  
  # West region
  'AK' = 'West',
  'AZ' = 'West',
  'CA' = 'West',
  'CO' = 'West',
  'HI' = 'West',
  'ID' = 'West',
  'MT' = 'West',
  'NV' = 'West',
  'NM' = 'West',
  'OR' = 'West',
  'UT' = 'West',
  'WA' = 'West',
  'WY' = 'West'
)

# Step 2: Map the states to regions
sample_data <- sample_data %>%
  mutate(region = state_regions[state])

# Check for NA's in the data
variable_na <- sample_data %>%
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(
    cols = everything(), 
    names_to = "variable", 
    values_to = "na_count"
  )

# Remove NA's in attributes, fans, and review count user data
sample_data <- sample_data %>% 
  filter(!is.na(attributes),
         !is.na(fans),
         !is.na(review_count_user))

# Create a take_out variable that contains 1 for take-out restaurants and
# 0 for non take-out restaurants
# Select only the take-out restaurants
sample_data <- sample_data %>%
  mutate(take_out = ifelse(str_detect(attributes, 
                                      "'RestaurantsTakeOut'\\s*:\\s*'True'"),
                           1, 0))

# Select only the take-out restaurants
takeout_data <- sample_data %>%
  filter(take_out == 1)

# Remove attribute column
takeout_data <- takeout_data %>% select(-attributes)

dir.create(here("3-final_data"), showWarnings = FALSE)
dir.create(here("7-plots"), showWarnings = FALSE)

colnames(takeout_data)

# Uni-variate Analysis
# Define the columns
columns <- c('review_count_user', 'fans','review_count_business')

# Define the path to save the figure
save_path <- '7-plots'

# Function to display and save boxplots
display_boxplots <- function(dataset, columns, save_path, figure_name) {
  # Create the directory if it doesn't exist
  if (!dir.exists(save_path)) {
    dir.create(save_path, recursive = TRUE)
  }
  
  # Set up a list to store plots
  plot_list <- list()
  
  # Loop through each column to create boxplots
  for (col in columns) {
    p <- ggplot(data = dataset, aes_string(y = col)) +
      geom_boxplot() +
      theme_minimal() +
      theme(panel.background = element_rect(fill = 'white', color = 'white')) +  # Set background to white
      ggtitle(paste("Boxplot of", col))
    plot_list[[col]] <- p
  }
  
  # Arrange the plots in a grid and save the figure
  grid_plot <- cowplot::plot_grid(plotlist = plot_list, ncol = 2)
  ggsave(filename = file.path(save_path, figure_name), plot = grid_plot, width = 15, height = length(columns) * 2.5, dpi = 300)
  
  # Display the grid plot
  print(grid_plot)
}

# Call the function to display and save the graph
display_boxplots(takeout_data, columns, save_path, 'figure_1_boxplots.png')

# Function to display and save histograms
display_histograms <- function(dataset, columns, save_path, figure_name) {
  # Create the directory if it doesn't exist
  if (!dir.exists(save_path)) {
    dir.create(save_path, recursive = TRUE)
  }
  
  # Set up a list to store plots
  plot_list <- list()
  
  # Loop through each column to create histograms
  for (col in columns) {
    p <- ggplot(data = dataset, aes_string(x = col)) +
      geom_histogram(binwidth = 10, fill = 'skyblue', color = 'black') +
      theme_minimal() +
      theme(panel.background = element_rect(fill = 'white', color = 'white')) +  # Set background to white
      ggtitle(paste("Histogram of", col)) +
      xlab(col) +
      ylab('Frequency')
    plot_list[[col]] <- p
  }
  
  # Arrange the plots in a grid and save the figure
  grid_plot <- cowplot::plot_grid(plotlist = plot_list, ncol = 2)
  ggsave(filename = file.path(save_path, figure_name), plot = grid_plot, width = 15, height = length(columns) * 2.5, dpi = 300)
  
  # Display the grid plot
  print(grid_plot)
}

# Call the function to display and save the graph
display_histograms(takeout_data, columns, save_path, 'figure_2_histograms.png')

### Output ###
write_csv(takeout_data, here("3-final_data", "takeout_data.csv"))
