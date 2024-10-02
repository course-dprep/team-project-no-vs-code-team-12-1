# Default target: Run everything in sequence
all: 1-docs/Group_Report.html

# Install packages target
packages: 6-source_code/0_install_packages.R
	Rscript 6-source_code/0_install_packages.R

# Target to download data
2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv: 6-source_code/1_download_data.R | 2-temporary_data
	Rscript 6-source_code/1_download_data.R

# Target to prepare data
2-temporary_data/sample_data.csv: 6-source_code/2_prepare_data.R 2-temporary_data/business_data.csv 2-temporary_data/user_data.csv 2-temporary_data/review_data.csv | 2-temporary_data
	Rscript 6-source_code/2_prepare_data.R

# Target to preprocess data
3-final_data/takeout_data.csv: 6-source_code/3_preprocessing_data.R 2-temporary_data/sample_data.csv | 3-final_data
	Rscript 6-source_code/3_preprocessing_data.R

# Target to create plots
7-plots: 6-source_code/4_plot_data.R 3-final_data/takeout_data.csv | 7-plots
	Rscript 6-source_code/4_plot_data.R

# Target to analyze data and create results
8-results: 6-source_code/5_analyse_data.R 3-final_data/takeout_data.csv | 8-results
	Rscript 6-source_code/5_analyse_data.R

# Target to knit the Quarto report
1-docs/Group_Report.html: 1-docs/Group_Report.qmd 3-final_data/takeout_data.csv 7-plots 8-results
	quarto render "1-docs/Group_Report.qmd" --to html

# Clean command to remove .csv files in specified directories
clean:
	rm -f 2-temporary_data/*.csv 3-final_data/*.csv
	rm -rf 7-plots/* 8-results/* 1-docs/*.html