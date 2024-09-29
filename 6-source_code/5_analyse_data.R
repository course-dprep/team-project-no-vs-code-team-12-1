### Libraries ###
library(tidyverse)
library(here)
library(dplyr)
library(grid)  # For text rendering as a plot
library(gridExtra)  # For arranging the text as a grob

### Create Results Directory ###
if (!dir.exists(here('8-results'))) {
  dir.create(here('8-results'))
}

### Input ###
takeout_data <- read_csv(here('3-final_data', 'takeout_data.csv'))
head(takeout_data)

# Ensure the key variables are correctly formatted
takeout_data <- takeout_data %>% mutate(elite_review = as.factor(elite_review), division = as.factor(division))

### Run Two-Way ANOVA ###
anova_results <- aov(stars_business ~ elite_review * division, data = takeout_data)

# Save ANOVA Summary to a Text File ###
anova_summary <- capture.output(summary(anova_results))
writeLines(anova_summary, here('8-results', 'anova_summary.txt'))

# Save ANOVA Summary as an Image ###
anova_summary_text <- paste(anova_summary, collapse = "\n")
anova_grob <- textGrob(anova_summary_text, x = 0, y = 1, just = c("left", "top"), gp = gpar(fontsize = 10))
anova_summary_image <- here('8-results', 'anova_summary.png')
png(anova_summary_image, width = 800, height = 600)
grid.draw(anova_grob)
dev.off()

# Save Normal Q-Q Plot ###
qq_plot <- here('8-results', 'normal_qq_plot.png')
png(qq_plot)
plot(anova_results, which = 2)  # Normal Q-Q plot
dev.off()

# Save Scale-Location Plot ###
scale_location_plot <- here('8-results', 'scale_location_plot.png')
png(scale_location_plot)
plot(anova_results, which = 3)  # Scale-Location plot for homogeneity of variance
dev.off()
