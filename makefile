# Targets and dependencies
3-final_data/takeout_data.csv: 6-source_code/preprocessing_data.R 2-temporary_data/sample_data.csv | 3-final_data
	Rscript 6-source_code/preprocessing_data.R

2-temporary_data/sample_data.csv: 6-source_code/prepare_data.R 2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv | 2-temporary_data
	Rscript 6-source_code/prepare_data.R

2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv: 6-source_code/download_data.R | 2-temporary_data
	Rscript 6-source_code/download_data.R

# Clean command to remove .csv files in specified directories
clean:
	R -e "unlink(c('2-temporary_data/*.csv', '3-final_data/*.csv'), recursive = FALSE)"
