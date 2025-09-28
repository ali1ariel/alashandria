defmodule Alashandria.Generator do
  use Ash.Generator
  alias Alashandria.Library.Category
  alias Alashandria.Library.Author
  alias Alashandria.Library.Book

  def book(opts \\ []) do
    author_id = opts[:author_id] || once(:default_author_id, fn -> generate(author()).id end)
    category_id = opts[:category_id] || once(:default_category_id, fn -> generate(category()).id end)

    changeset_generator(
      Book,
      :create,
      defaults: [
        author_id: author_id,
        category_id: category_id,
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
        name: Faker.Person.name(),
        nationality: StreamData.member_of(["BR", "PT", "US"]),
        bio: Faker.Lorem.Shakespeare.as_you_like_it()
      ],
      overrides: opts
    )
  end

  def category(opts \\ []) do
    changeset_generator(
      Category,
      :create,
      defaults: [
        name: Faker.Cat.name()
      ],
      overrides: opts
    )
  end
end
