# Wiki.js Development Environment Instructions

This document provides instructions on how to set up, manage, and troubleshoot the Wiki.js development environment using Docker Compose.

## Requirements

Before you begin, ensure you have the following installed on your system:

- **Docker**: Container runtime.
- **Docker Compose**: Tool for defining and running multi-container Docker applications.
- **Bash**: Shell for running the helper scripts (available by default on Linux/macOS; use Git Bash or WSL on Windows).

## Shell Scripts Usage

We provide several shell scripts in `environments/dev` to simplify common tasks.

### Starting the Environment

To start the Wiki.js development environment (PostgreSQL, Wiki.js, Elasticsearch):

```bash
./environments/dev/start-wiki-dev.sh
```

This script will:
1.  Pull the latest Docker images.
2.  Start the services in detached mode.
3.  Print the status of the services.

### Backing Up the Database

To create a SQL dump of the PostgreSQL database:

```bash
./environments/dev/backup-wiki.sh
```

- Backups are saved in `environments/dev/data/` with a timestamped filename (e.g., `wiki_backup_20251128_120000.sql`).
- The script reads credentials from the `.env` file.

### Resetting the Environment

**WARNING**: This will delete all data in the database and search index.

To stop containers and remove all volumes:

```bash
./environments/dev/reset-wiki-dev.sh
```

Use this when you want to start fresh.

## Docker Compose Scenarios

You can also use standard Docker Compose commands from the `environments/dev` directory.

**Note**: You must be in the `environments/dev` directory to run these commands, or use the `-f` flag to point to the file.

### Checking Status

To see the status of running containers:

```bash
cd environments/dev
docker-compose ps
```

### Viewing Logs

To view logs for all services:

```bash
cd environments/dev
docker-compose logs -f
```

To view logs for a specific service (e.g., `wiki`):

```bash
cd environments/dev
docker-compose logs -f wiki
```

### Executing Commands

To open a shell inside the `wiki` container:

```bash
cd environments/dev
docker-compose exec wiki /bin/sh
```

To open a shell inside the `db` container:

```bash
cd environments/dev
docker-compose exec db /bin/bash
```

## Configuration (.env)

The environment is configured via the `.env` file in `environments/dev`. Copy `.env-sample` to `.env` to get started.

| Variable | Description | Default |
| :--- | :--- | :--- |
| `POSTGRES_DB` | Name of the PostgreSQL database. | `wiki` |
| `POSTGRES_USER` | Username for PostgreSQL. | `wikijs` |
| `POSTGRES_PASSWORD` | Password for PostgreSQL. | `wikijsrocks` |
| `WIKI_PORT` | Host port mapped to Wiki.js (container port 3000). | `3000` |
| `ES_PORT` | Host port mapped to Elasticsearch (container port 9200). | `9200` |

**Important**: If you change `POSTGRES_USER` or `POSTGRES_PASSWORD`, you must also update the `DB_USER` and `DB_PASS` environment variables in the `wiki` service section of `docker-compose.yml` if they are not already using variable substitution (currently they are).
