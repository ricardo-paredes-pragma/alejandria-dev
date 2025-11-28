#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Navigate to the script directory
cd "$(dirname "$0")"

echo -e "${YELLOW}WARNING: This will stop the Wiki.js environment and DELETE ALL DATA in the volumes (Postgres & Elasticsearch).${NC}"
read -p "Are you sure you want to proceed? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 1
fi

echo -n "Stopping services and removing volumes... "
if docker-compose down -v > /dev/null 2>&1; then
    echo -e "${GREEN}Done${NC}"
else
    echo -e "${RED}Failed${NC}"
    exit 1
fi

echo -e "${GREEN}Environment reset successfully.${NC}"
echo "You can now run ./start-wiki-dev.sh to start a fresh environment."
