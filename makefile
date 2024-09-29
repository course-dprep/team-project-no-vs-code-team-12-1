# Default target: Run everything in sequence
all: 3-final_data/takeout_data.csv

# Targets and dependencies
3-final_data/takeout_data.csv: 6-source_code/3_preprocessing_data.R 2-temporary_data/sample_data.csv | 3-final_data
	Rscript 6-source_code/3_preprocessing_data.R

2-temporary_data/sample_data.csv: 6-source_code/2_prepare_data.R 2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv | 2-temporary_data
	Rscript 6-source_code/2_prepare_data.R

2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv: 6-source_code/1_download_data.R | 2-temporary_data
	Rscript 6-source_code/1_download_data.R

# Install packages target
packages: 6-source_code/0_install_packages.R
	Rscript 6-source_code/0_install_packages.R

# Final target to execute everything, starting with installing packages
3-final_data/takeout_data.csv: packages

# Clean command to remove .csv files in specified directories
clean:
	R -e "unlink(c('2-temporary_data/*.csv', '3-final_data/*.csv'), recursive = FALSE)"