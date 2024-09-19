import pandas as pd
import numpy as np

df_sample = pd.read_csv('sample_data.csv')

df_sample.head()

df_sample[df_sample['elite'].notnull()]

df_population = pd.read_csv('yelp_academic_dataset_user.csv')

# Keep only 'user_id' and 'elite' columns in the df_population
df_population_filtered = df_population[['user_id', 'elite']]

# Perform a left join between df_sample and df_population_filtered based on 'user_id'
df_merged = pd.merge(df_sample, df_population_filtered, on='user_id', how='left')

# Remove the 'elite_x' column and rename 'elite_y' to 'elite'
df_merged_cleaned = df_merged.drop(columns=['elite_x'])  # Drop 'elite_x'
df_merged_cleaned = df_merged_cleaned.rename(columns={'elite_y': 'elite'})  # Rename 'elite_y' to 'elite'

df_merged_cleaned[df_merged_cleaned['elite'].notnull()]

# Convert all values in the 'elite' column to strings
df_merged_cleaned['elite'] = df_merged_cleaned['elite'].astype(str)

df_merged_cleaned.to_csv('cleaned_sample_data.csv', index=False)
