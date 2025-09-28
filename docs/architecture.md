# 🔐 AlASHandria - System architecture

This file contains implementation details about the system, with tables layout and some implementation decisions.

## Stack

### Backend

- **Language**: Elixir
- **Framework Web**: Ash Framework with Absinthe
- **Database**: Mnesia (in memory database)

## Data Architecture

### ER Diagram

```mermaid
erDiagram
    AUTHOR ||--o{ BOOK : writes
    CATEGORY ||--o{ BOOK : contains

    AUTHOR {

        UUID id PK
        STRING name
        STRING bio
        DATE birth_date
        DATE death_date
        STRING nationality
        DATETIME inserted_at
        DATETIME updated_at

    }

    CATEGORY {
        UUID id PK
        STRING name
        DATETIME inserted_at
        DATETIME updated_at
    }

    BOOK {
        UUID id PK
        UUID category_id FK
        UUID author_id FK
        STRING name
        INTEGER pages
        INTEGER edition
        STRING description
        STRING isbn
        STRING language
        INTEGER total_copies
        DATETIME inserted_at
        DATETIME updated_at
    }
```
