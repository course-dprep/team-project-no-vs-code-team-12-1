3. final_data/takeout_data.csv: preprocessing_data.R 2. temporary_data/sample_data.csv
	R --vanilla < preprocessing_data.R

2. temporary_data/sample_data.csv: prepare_data.R 






clean:
	R -e "unlink('*.csv')"