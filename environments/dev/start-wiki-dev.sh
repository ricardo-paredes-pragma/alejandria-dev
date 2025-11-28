#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Starting Wiki.js development environment..."

# Navigate to the script directory to ensure docker-compose commands work correctly
cd "$(dirname "$0")"

# Task 1: Pull images
echo -n "Pulling Docker images... "
if docker-compose pull > /dev/null 2>&1; then
    echo -e "${GREEN}Done${NC}"
else
    echo -e "${RED}Failed${NC}"
    exit 1
fi

# Task 2: Start services
echo -n "Starting services... "
if docker-compose up -d > /dev/null 2>&1; then
    echo -e "${GREEN}Done${NC}"
else
    echo -e "${RED}Failed${NC}"
    exit 1
fi

echo -e "${GREEN}Wiki.js development environment started successfully!${NC}"

# Task 3: Print Service Status
echo ""
echo "Service Status:"
docker-compose ps

echo ""
echo "Access Wiki.js at http://localhost:3000 (or configured port)"
