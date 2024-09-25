# -*- coding: utf-8 -*-
"""Convert the Yelp Dataset Challenge dataset from json format to csv.
For more information on the Yelp Dataset Challenge please visit http://yelp.com/dataset_challenge
"""
import argparse
import csv
import json
import os


def read_and_write_file(json_file, csv_file, column_names):
    with open(json_file, 'r', encoding='utf-8') as f, open(csv_file, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=column_names)
        writer.writeheader()
        for line in f:
            data = json.loads(line)
            writer.writerow(data)
    print(f"CSV file '{csv_file}' has been created successfully.")

def get_superset_of_column_names_from_file(json_file):
    column_names = set()
    with open(json_file, 'r', encoding='utf-8') as f:
        for line in f:
            data = json.loads(line)
            column_names.update(data.keys())
    return list(column_names)


def process_line(line_value):
    row = []
    if isinstance(line_value, str):
        row.append('{0}'.format(line_value))
    elif line_value is not None:
        row.append('{0}'.format(line_value))
    else:
        row.append('')
    return row


if __name__ == '__main__':
    # Convert a yelp dataset file from json to csv.
    print("Starting the conversion process...")

    parser = argparse.ArgumentParser(
        description='Convert Yelp Dataset Challenge data from JSON format to CSV.',
    )

    parser.add_argument(
        'json_file',
        type=str,
        help='The json file to convert.',
    )

    args = parser.parse_args()

    json_file = args.json_file
    csv_file = '{0}.csv'.format(json_file.split('.json')[0])

    # Print current working directory
    print(f"Current working directory: {os.getcwd()}")

    # Print absolute path of the JSON file
    abs_json_file_path = os.path.abspath(json_file)
    print(f"Absolute path of JSON file: {abs_json_file_path}")

    if not os.path.isfile(json_file):
        print(f"Error: The file '{json_file}' does not exist.")
        exit(1)

    print(f"Input JSON file: {json_file}")
    print(f"Output CSV file: {csv_file}")

    column_names = get_superset_of_column_names_from_file(json_file)
    print(f"Column names: {column_names}")

    read_and_write_file(json_file, csv_file, column_names)
    print("Conversion process completed.")

