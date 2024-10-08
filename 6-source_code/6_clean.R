# clean.R
# Remove CSV files from the specified directories
unlink("2-temporary_data/*.csv", recursive = FALSE)
unlink("3-final_data/*.csv", recursive = FALSE)
unlink("7-plots/*", recursive = TRUE)
unlink("8-results/*", recursive = TRUE)
unlink("1-docs/*.html", recursive = FALSE)