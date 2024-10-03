### Libraries ###
library(tidyverse)
library(here)
library(dplyr)
library(grid)
library(gridExtra)
library(sjPlot)
library(sjmisc)

### Create Results Directory ###
if (!dir.exists(here('8-results'))) {
  dir.create(here('8-results'))
}

### Input ###
takeout_data <- read_csv(here('3-final_data', 'takeout_data.csv'))

# Ensure the key variables are correctly formatted
takeout_data <- takeout_data %>%
  mutate(
    elite_review = as.factor(elite_review),
    region = as.factor(region),
    is_open = as.factor(is_open)
  )

### Run Two-Way ANOVA ###
anova_results <- aov(stars_user ~ elite_review * region, data = takeout_data)

# Get ANOVA summary
anova_summary <- summary(anova_results)

# Save ANOVA Summary to a Text File
anova_summary_text <- capture.output(anova_summary)
writeLines(anova_summary_text, here('8-results', 'anova_summary.txt'))

# Run Tukey's HSD Post Hoc Test
anova_tukey <- TukeyHSD(anova_results)

# Save Tukey HSD Results to a Text File
tukey_summary_text <- capture.output(anova_tukey)
writeLines(tukey_summary_text, here('8-results', 'tukey_hsd_summary.txt'))

# Run Pairwise T-Test with Bonferroni Correction
pairwise_results <- pairwise.t.test(takeout_data$stars_user, takeout_data$region, p.adjust.method = "bonferroni")

# Save Pairwise T-Test Results to a Text File
pairwise_summary_text <- capture.output(pairwise_results)
writeLines(pairwise_summary_text, here('8-results', 'pairwise_t_test_summary.txt'))

### Save ANOVA Diagnostic Plots ###

# Save Normal Q-Q Plot
qq_plot_file <- here('8-results', 'anova_normal_qq_plot.png')
png(qq_plot_file)
plot(anova_results, which = 2)  # Normal Q-Q plot
dev.off()

# Save Scale-Location Plot
scale_location_plot_file <- here('8-results', 'anova_scale_location_plot.png')
png(scale_location_plot_file)
plot(anova_results, which = 3)  # Scale-Location plot
dev.off()

### Run Regression Analysis ###
takeout_regression <- glm(
  stars_user ~ elite_review + review_count_user + fans + is_open + stars_business,
  data = takeout_data
)

# Get Regression Summary
regression_summary <- summary(takeout_regression)

# Save Regression Summary to a Text File
regression_summary_text <- capture.output(regression_summary)
writeLines(regression_summary_text, here('8-results', 'regression_summary.txt'))

### Save Regression Diagnostic Plots ###

# Save Normal Q-Q Plot for Regression
qq_plot_reg_file <- here('8-results', 'regression_normal_qq_plot.png')
png(qq_plot_reg_file)
qqnorm(residuals(takeout_regression))
qqline(residuals(takeout_regression), col = "red")
dev.off()

# Save Residuals vs Fitted Plot
residuals_plot_file <- here('8-results', 'regression_residuals_fitted_plot.png')
png(residuals_plot_file)
plot(takeout_regression$fitted.values, residuals(takeout_regression),
     xlab = "Fitted Values", ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")
dev.off()

