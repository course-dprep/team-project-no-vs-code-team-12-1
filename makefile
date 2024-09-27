3-final_data/takeout_data.csv: 6-source_code/preprocessing_data.R 2-temporary_data/sample_data.csv
	R --vanilla < 6-source_code/preprocessing_data.R

2-temporary_data/sample_data.csv: 6-source_code/prepare_data.R 
	R --vanilla < 6-source_code/prepare_data.R 2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv

2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv: 6-source_code/download_data.R
	R --vanilla < 6-source_code/download_data.R 

clean:
	R -e "unlink('*.csv')"