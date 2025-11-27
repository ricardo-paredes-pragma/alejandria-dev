#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directory where the script is located
SCRIPT_DIR="$(dirname "$0")"
BACKUP_DIR="$SCRIPT_DIR/data"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/wiki_backup_$TIMESTAMP.sql"

echo "Starting Wiki.js database backup..."

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Navigate to script directory for docker-compose context
cd "$SCRIPT_DIR"

# Load environment variables if present
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Default values if not set in .env
DB_USER=${POSTGRES_USER:-wikijs}
DB_NAME=${POSTGRES_DB:-wiki}

echo -n "Generating backup to $BACKUP_FILE... "

# Run pg_dump inside the container
if docker-compose exec -T db pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"; then
    echo -e "${GREEN}Done${NC}"
    echo "Backup size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
    echo -e "${RED}Failed${NC}"
    # Remove empty file if failed
    rm -f "$BACKUP_FILE"
    exit 1
fi

echo -e "${GREEN}Backup completed successfully!${NC}"
