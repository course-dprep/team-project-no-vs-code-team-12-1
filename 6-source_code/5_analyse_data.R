### Libraries ###
library(tidyverse)
library(here)
library(dplyr)
library(grid)
library(gridExtra)
library(sjPlot)
library(sjmisc)
library(car)
library(emmeans)
library(effectsize)

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

### Get descriptives ###

# Get descriptives of star ratings based on elite status
takeout_data %>% 
  group_by(elite_review) %>% 
  summarize(mean_stars = mean(stars_user),
            sd_stars = sd(stars_user))

# Get descriptives of star ratings based on region and elite status
takeout_data %>% 
  group_by(region) %>% 
  summarize(mean_stars = mean(stars_user),
            sd_stars = sd(stars_user))

takeout_data %>% 
  group_by(region, elite_review) %>% 
  summarize(mean_stars = mean(stars_user),
            sd_stars = sd(stars_user))

# Get mean star rating based on division and elite status
takeout_data %>% 
  group_by(division) %>% 
  summarize(mean_stars = mean(stars_user))

takeout_data %>% 
  group_by(division, elite_review) %>% 
  summarize(mean_stars = mean(stars_user))

### Assumption checks ###

# Homoscedasticity
leveneTest(stars_user ~ elite_review*region, data = takeout_data,
           center = mean)




### Run Two-Way ANOVA ###
anova_results <- aov(stars_user ~ elite_review * region, data = takeout_data)


takeout_anova  <- lm(stars_user ~ elite_review * region, data = takeout_data)
anova_results2 <- Anova(takeout_anova, type=3)
anova_results2

# Get ANOVA summaries
anova_summary <- summary(anova_results)
anova_summary

anova_summary2 <- summary(anova_results2)
anova_summary2

# Save ANOVA Summary to a Text File
anova_summary_text <- capture.output(anova_summary)
writeLines(anova_summary_text, here('8-results', 'anova_summary.txt'))

anova_summary_text2 <- capture.output(anova_summary2)
writeLines(anova_summary_text2, here('8-results', 'anova_summary2.txt'))

### Check normality ###
ks.test(takeout_anova$residuals, "pnorm",
        mean=mean(takeout_anova$residuals),
        sd=sd(takeout_anova$residuals))


### Post hoc tests

# emmeans test
emmeans(takeout_anova, pairwise ~ elite_review*region, adjust='bonferroni')

# Run Tukey's HSD Post Hoc Test
anova_tukey <- TukeyHSD(anova_results)
anova_tukey

# Save Tukey HSD Results to a Text File
tukey_summary_text <- capture.output(anova_tukey)
writeLines(tukey_summary_text, here('8-results', 'tukey_hsd_summary.txt'))

# Run Pairwise T-Test with Bonferroni Correction
pairwise_results <- pairwise.t.test(takeout_data$stars_user, 
                                    takeout_data$region, 
                                    p.adjust.method = "bonferroni")
pairwise_results

# Save Pairwise T-Test Results to a Text File
pairwise_summary_text <- capture.output(pairwise_results)
writeLines(pairwise_summary_text, 
           here('8-results', 'pairwise_t_test_summary.txt'))

# Partial eta squared
effectsizes <- eta_squared(takeout_anova, ci=0.95, partial=TRUE)
effectsizes

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
takeout_lm1 <- lm(
  stars_user ~ elite_review + review_count_user + fans + 
    is_open,
  data = takeout_data
)

vif(takeout_lm1)

# Get Regression Summary
regression1_summary <- summary(takeout_lm1)
regression1_summary

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

# Space for extra plots

