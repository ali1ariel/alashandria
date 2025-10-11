defmodule Alashandria.AuthorTest do
  use ExUnit.Case, async: false

  alias Alashandria.Library.Catalog.Author
  alias Alashandria.Catalog.Helper, as: CatalogHelper
  # alias Ash.Domain

  import Alashandria.Generator
  import ExUnitProperties

  test "the author are being created" do
    author = generate(author())

    loaded_author = Ash.load!(author, :books)
    assert Enum.count(loaded_author.books) == 0

    generate_many(book(author_id: loaded_author.id), 10)

    new_loaded_author = Ash.load!(author, :books)
    assert Enum.count(new_loaded_author.books) == 10
  end

  property "author creation validates correctly" do
    check all(
            input <-
              Ash.Generator.action_input(Author, :create, %{
                name: StreamData.string(:alphanumeric, min_length: 2, max_length: 50),
                nationality: StreamData.member_of(["BR", "PT", "US"]),
                bio: Faker.Lorem.Shakespeare.as_you_like_it()
              })
          ) do
      author = CatalogHelper.create_author(input)

      assert author.name == input.name
      assert author.nationality == input.nationality
    end
  end
end
