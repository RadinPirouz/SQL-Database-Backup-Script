#!/bin/bash
# This IS BETA Version :)))




# Set variables
file_name=$(date +%Y%m%d_%H%M%S)
password=""
database_name=""
user="postgres"  # Adjust if using a different user
host="localhost"  # Adjust if the database is on a different server
port="5432"      # Adjust if using a different port
directory_to_save="/path/PG_Backup"
webhook_url=""

# Ensure the backup directory exists
mkdir -p "$directory_to_save"

# Backup PostgreSQL database
echo "Starting PostgreSQL Backup..."
pg_dump -u "$user" -h "$host" -p "$port" -d "$database_name" > "$directory_to_save/$file_name.sql" \
    2> "$directory_to_save/$file_name_error.log"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "PostgreSQL Backup completed successfully."

  # Send notification via Discord webhook
  bash discord.sh --webhook-url "$webhook_url" --file "$directory_to_save/$file_name.sql"

  # Clean up SQL backup file (optional)
  # rm -f "$directory_to_save/$file_name.sql"

  echo "Cleanup completed."
else
  echo "PostgreSQL Backup failed. Check error log: $directory_to_save/$file_name_error.log"
fi
