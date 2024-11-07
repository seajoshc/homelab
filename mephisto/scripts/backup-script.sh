#!/bin/bash

# Exit on error
set -e

# Load environment variables
source /etc/restic-env

# Paths to backup
BACKUP_PATHS="/var/lib/docker/volumes \
             /home \
             /etc \
             /usr/local/etc"

# Initialize the repository if it doesn't exist
restic snapshots || restic init

# Perform the backup
restic backup $BACKUP_PATHS

# Keep the last 6 snapshots (72 hours worth, given 12-hour frequency)
# Keep 1 snapshot per week for all other snapshots
restic forget --keep-last 6 --keep-weekly 1 --prune
