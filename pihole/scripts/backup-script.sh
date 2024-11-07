#!/bin/bash

# Exit on error
set -e

# Load environment variables
source /etc/restic-env

# Paths to backup
BACKUP_PATHS="/home \
             /etc \
             /usr/local/etc"

# Initialize the repository if it doesn't exist
restic snapshots || restic init

# Perform the backup
restic backup $BACKUP_PATHS

# Keep the last 3 snapshots (72 hours worth, given 24-hour frequency)
# Keep 1 snapshot per week and 1 per month for all other snapshots
restic forget --keep-last 3 --keep-weekly 1 --keep-monthly 1 --prune
