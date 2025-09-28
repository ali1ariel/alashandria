# 🔐 AlASHandria - System architecture

This file contains implementation details about the system, with tables layout and some implementation decisions.

## Stack

### Backend

- **Language**: Elixir
- **Framework Web**: Ash Framework with Absinthe
- **Database**: Mnesia (in memory database)

## Data Architecture

### ER Diagrams

#### Catalog

```mermaid
---
config:
  layout: elk
---
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

#### LOAN

```mermaid
---
config:
  layout: elk
---
erDiagram
    ATTENDANT ||--o{ LOAN : processes
    ATTENDANT ||--o{ RENEWAL : "extends the deadline"
    ATTENDANT ||--o{ FEE : applies
    USER ||--o{ LOAN : borrows
    USER ||--o{ RESERVE : "shows interest"
    LOAN ||--o| FEE : "may incur"
    LOAN ||--o{ RENEWAL : "renews and recalc expect return date"
    RESERVE ||--o| LOAN : "may become"
    LOAN {
        UUID id PK
        UUID user_id FK
        UUID attendant_id FK
        UUID from_reserve_id FK "nullable"
        UUID book_id FK
        DATETIME lent_at
        DATE expected_return_date
        DATETIME returned_at "nullable"
    }
    RENEWAL {
        UUID id PK
        UUID loan_id FK
        UUID attendant_id FK
        DATETIME renewed_at
    }
    FEE {
        UUID id PK
        UUID loan_id FK
        UUID attendant_id FK
        DECIMAL value
        STRING type
    }
    RESERVE {
        UUID id PK
        UUID user_id FK
        UUID book_id FK
        BOOLEAN was_canceled
        DATETIME reserved_at
    }

```

#### Users and authentication

```mermaid
---
config:
  layout: elk
---
erDiagram
    ATTENDANT ||--o{ BOOK : register
    ATTENDANT ||--o{ AUTHOR : register
    ATTENDANT ||--o{ CATEGORY : register
    ATTENDANT ||--o{ LOAN : process
    ATTENDANT ||--o{ FEE : apply
    ATTENDANT ||--o{ RENEWAL : renews
    ATTENDANT ||--o{ USER : creates
    USER ||--o{ RESERVE : "shows interest"

    USER {
        UUID id PK
        UUID attendant_id FK
        DATETIME inserted_at
        STRING name
        STRING email
        STRING phone
    }

    ATTENDANT {
        UUID id PK
        STRING name
        STRING email
    }

```
