# alASHandria

> A library that burns all the books all the time. (In memory with ETS, if you did not get it...)

[![Elixir](https://img.shields.io/badge/Elixir-1.17+-blueviolet.svg)](https://elixir-lang.org/)
[![Ash Framework](https://img.shields.io/badge/Ash-3.0+-orange.svg)](https://ash-hq.org/)
[![GraphQL](https://img.shields.io/badge/GraphQL-Enabled-e10098.svg)](https://graphql.org/)

A simple library management system built with Elixir and Ash Framework. Features automatic GraphQL API generation from declarative resources.

## Quick Start

**Requirements:** Elixir 1.17+

```bash
git clone https://github.com/yourusername/alashandria.git
cd alashandria
mix deps.get
mix run --no-halt
```

GraphQL playground: `http://localhost:4000/graphiql`

## Example Usage

Create an author and book:

```graphql
mutation {
  createAuthor(input: {
    name: "Machado de Assis"
    nationality: "BR"
  }) {
    result { id name }
  }
}

mutation {
  createBook(input: {
    name: "Dom Casmurro"
    pages: 200
    edition: 1
    authorId: "author-id-here"
  }) {
    result {
      id
      name
      author { name }
    }
  }
}
```

Search with filters:

```graphql
query {
  searchAuthors(name: "Machado", nationality: "BR") {
    id
    name
    books { name pages }
  }
}
```

Just it, welcome.

Oh, the rest of the doc 😲? Oh no... I think I burned it by accident. 
