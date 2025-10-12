defmodule Alashandria.AuthorTest do
  use ExUnit.Case, async: false

  alias Alashandria.Library.Catalog.Author
  alias Alashandria.Library.Catalog
  # alias Ash.Domain

  use Alashandria.Generator
  import ExUnitProperties

  test "success: the author really wrote the books that he said" do
    author = generate(author())

    loaded_author = Ash.load!(author, :books)
    assert Enum.count(loaded_author.books) == 0

    generate_many(book(author_id: loaded_author.id), 10)

    new_loaded_author = Ash.load!(author, :books)
    assert Enum.count(new_loaded_author.books) == 10
  end

  test "failed: the changeset is not valid with invalid params" do
    changeset = Catalog.changeset_to_create_author(%{})

    Enum.map(changeset.errors, fn error ->
      case error do
        e = %Ash.Error.Changes.InvalidAttribute{} -> assert e.field == :name and e.message =~ "must be present"
        e = %Ash.Error.Changes.Required{} -> assert e.field == :name
      end
    end)

    refute changeset.valid?
  end

  property "success: author is created correctly with correct params" do
    check all(
            input <-
              Ash.Generator.action_input(Author, :create, %{
                name: StreamData.string(:alphanumeric, min_length: 2, max_length: 50),
                nationality: StreamData.member_of(["BR", "PT", "US"]),
                bio: Faker.Lorem.Shakespeare.as_you_like_it()
              })
          ) do
      {:ok, author} = Catalog.create_author(input)

      assert author.name == input.name
      assert author.nationality == input.nationality
    end
  end
end
