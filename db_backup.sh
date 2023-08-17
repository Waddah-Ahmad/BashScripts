#!/bin/bash

# MySQL database information
db_user="your_db_username"
db_password="your_db_password"
db_name="your_database_name"

# Backup directory
backup_dir="/path/to/backup"

# Create a timestamp for the backup
timestamp=$(date +%Y%m%d%H%M%S)

# Backup file name
backup_file="$backup_dir/db_backup_$timestamp.sql"

# Create the backup
mysqldump -u "$db_user" -p"$db_password" "$db_name" > "$backup_file"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Database backup created successfully: $backup_file"
else
    echo "Database backup failed"
fi