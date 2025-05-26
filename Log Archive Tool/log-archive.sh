#!/bin/bash

# Check if argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"

# Check if the provided argument is a valid directory
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: '$LOG_DIR' is not a valid directory."
    exit 1
fi

# Create archive directory if it doesn't exist
ARCHIVE_DIR="./archived-logs"
mkdir -p "$ARCHIVE_DIR"

# Generate timestamp and archive file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_FILE}"

# Compress the logs
tar -czf "$ARCHIVE_PATH" -C "$(dirname "$LOG_DIR")" "$(basename "$LOG_DIR")"

# Log the archive operation
echo "$(date) - Archived '$LOG_DIR' to '$ARCHIVE_PATH'" >> "${ARCHIVE_DIR}/archive_log.txt"

echo "Logs archived successfully to $ARCHIVE_PATH"
