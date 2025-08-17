defmodule Alashandria.Generator do
  use Ash.Generator
  alias Alashandria.Library.Author
  alias Alashandria.Library.Book

  def book(opts \\ []) do
    author_id = opts[:author_id] || once(:default_author_id, fn -> generate(author()).id end)

    changeset_generator(
      Book,
      :create,
      defaults: [
        author_id: author_id,
        name: Faker.Cat.name(),
        pages: 200,
        edition: 2
      ],
      overrides: opts
    )
  end

  def author(opts \\ []) do
    changeset_generator(
      Author,
      :create,
      defaults: [
        name: Faker.Person.name()
      ],
      overrides: opts
    )
  end
end
