# alejandria-dev
Proyecto para pruebas internas de WikiJs

## Business Context

TO DO Business Context

## Requirements

TO DO Requirements

## Non-Functional Requirements

TO DO Non-Functional Requirements


## Architecture

```mermaid
graph TD
    User[User] -->|HTTP:3000| Wiki[Wiki.js]
    Wiki -->|TCP:5432| DB[PostgreSQL]
    Wiki -->|TCP:9200| ES[Elasticsearch]
    Wiki -->|TCP:443| GIT[GitHub]
    DB -->|Mount| VolDB[db-data Volume]
    ES -->|Mount| VolES[es-data Volume]
    Storage -->|Mount| VolStorage[storage Volume]
```
