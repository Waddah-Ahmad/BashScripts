#!/bin/bash

# Directory containing log files
log_dir="/path/to/log/files"

# Number of days to retain log files
days_to_retain=7

# Calculate the threshold date
threshold_date=$(date -d "$days_to_retain days ago" +%Y%m%d)

# Loop through log files in the directory
for log_file in "$log_dir"/*; do
    # Extract the file's last modified date in YYYYMMDD format
    file_date=$(date -r "$log_file" +%Y%m%d)
    
    # Compare file date with threshold date
    if [ "$file_date" -lt "$threshold_date" ]; then
        # Delete the log file
        rm "$log_file"
        echo "Deleted: $log_file"
    fi
done