# SQL Database Backup Script

This bash script automates the process of backing up a MySQL database and sending a notification via Discord webhook upon completion.

## Prerequisites

- MySQL installed and accessible.
- Access to the MySQL database you intend to back up.
- `discord.sh` script for sending notifications via Discord webhook. [Discord.sh Download Link](https://github.com/fieu/discord.sh/releases/tag/v2.0.0)

## Usage

1. Clone this repository to your local machine.
2. Modify the script to suit your environment:
   - Set the `password` variable to your MySQL database password.
   - Set the `database_name` variable to the name of the MySQL database you want to back up.
   - Set the `directory_to_save` variable to the directory where you want to store the backup files.
   - Set the `webhook_url` variable to your Discord webhook URL.
3. Ensure executable permissions for the script:
   ```bash
   chmod +x SQL_Backup.sh
   ```
4. Run the script:
   ```bash
   ./SQL_Backup.sh
   ```

## Script Overview

- **Variables:**
  - `file_name`: Timestamp used for naming the backup file.
  - `password`: MySQL database password.
  - `database_name`: Name of the MySQL database to be backed up.
  - `directory_to_save`: Directory to save the backup file.
  - `webhook_url`: Discord webhook URL for sending notifications.
  
- **Backup Process:**
  1. Checks if the backup directory exists; if not, creates it.
  2. Performs a MySQL database dump and saves it to a file in the specified directory.
  3. Sends a notification via Discord webhook upon successful backup.
  4. Cleans up the backup file after sending the notification.
  
## Setting Up a Cronjob

To schedule regular backups using cron, follow these steps:

1. Open your crontab file for editing:
   ```bash
   crontab -e
   ```

2. Add a new line to schedule the script to run at your desired interval. For example, to run the script every hour:
   ```bash
   0 * * * *  bash /path/SQL_Backup.sh
   ```
   Replace `/path/SQL_Backup.sh` with the actual path to your script file.

3. Save and exit the crontab editor. The cronjob will now execute the backup script every hour.

## Note

- This script assumes you have `mysqldump` installed, which is typically available with MySQL installations.
- Ensure the `discord.sh` script is available in your environment and properly configured to send Discord notifications.

