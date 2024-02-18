#!/bin/bash

# Set variables
file_name=$(date +%Y%m%d_%H%M%S)
password=""
database_name=""
directory_to_save="/path/SQL_Backup"
webhook_url="

# Ensure the backup directory exists
mkdir -p "$directory_to_save"

# Backup SQL database
echo "Starting SQL Backup..."
mysqldump -u usr --password="$password" "$database_name" > "$directory_to_save/$file_name.sql"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "SQL Backup completed successfully."
    
    # Send notification via Discord webhook
    bash discord.sh --webhook-url "$webhook_url" --file "$directory_to_save/$file_name.sql"
    
    # Clean up SQL backup file
    rm -f "$directory_to_save/$file_name.sql"
    
    echo "Cleanup completed."
else
    echo "SQL Backup failed."
fi
