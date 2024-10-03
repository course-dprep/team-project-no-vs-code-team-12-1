# Set a CRAN mirror
options(repos = c(CRAN = "https://cran.rstudio.com"))

# WORKING DIRECTORY SETTING PACKAGES
install.packages("here")
install.packages("rstudioapi")

# GENERAL PACKAGES
install.packages(c("tidyverse", "googledrive", "readr", "dplyr"))

# R MARKDOWN RENDER
install.packages("reticulate")
install.packages("knitr")

# ANALYSIS PACKAGES
install.packages("ggcorrplot")
install.packages("sjPlot")
install.packages("sjmisc")


# Install the gridExtra package
install.packages("gridExtra")