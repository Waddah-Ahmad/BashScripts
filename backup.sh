#!/bin/bash

# Source directory to backup
source_dir="/path/to/source"

# Destination directory for backups
backup_dir="/path/to/backup"

# Create a timestamp for the backup
timestamp=$(date +%Y-%m-%d-%H-%M-%S-backup)

# Create a backup directory with timestamp
backup_destination="$backup_dir/backup_$timestamp"
mkdir -p "$backup_destination"

# Copy files from source to backup directory
cp -r "$source_dir" "$backup_destination"

# Create a compressed archive of the backup
backup_archive="$backup_dir/backup_$timestamp.tar.gz"
tar -czvf "$backup_archive" -C "$backup_dir" "backup_$timestamp"

# Copy the compressed backup to another location (replace with actual destination)
destination_copy="/path/to/destination"
cp "$backup_archive" "$destination_copy"

# Print backup completed message
echo "Backup completed: $source_dir copied to $backup_destination and archived as $backup_archive"
echo "Backup copied to another location: $backup_archive copied to $destination_copy"
