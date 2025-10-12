defmodule Alashandria.Library.Catalog.BookTest do
  use ExUnit.Case
  use Alashandria.Generator

  import ExUnitProperties

  alias Alashandria.Library.Catalog
  alias Alashandria.Library.Catalog.Book

  setup do
    %{author: generate(author()), category: generate(category())}
  end

  describe "creating books" do
    property "success: creates a book when all data is valid", %{
      author: author,
      category: category
    } do
      check all(
              input <-
                Ash.Generator.action_input(Book, :create, %{
                  author_id: author.id,
                  category_id: category.id,
                  name: "#{Faker.Cat.name()} #{Faker.Cat.name()}",
                  pages: Enum.random(1..200),
                  edition: 2
                })
            ) do
        assert Catalog.changeset_to_create_book(input).valid?
      end
    end

    test "failed: the changeset is not valid with invalid params" do
      changeset = Catalog.changeset_to_create_book(%{})

      Enum.map(changeset.errors, fn error ->
        case error do
          e = %Ash.Error.Changes.Required{} ->
            assert e.field in [:author_id, :category_id]

          e = %Ash.Error.Changes.InvalidAttribute{} ->
            assert e.field in [:author_id, :category_id]

          e = %Ash.Error.Changes.InvalidChanges{} ->
            assert e.message =~ "must be present"
        end
      end)

      refute changeset.valid?
    end

    test "success: creating book with valid author and category", %{author: author, category: category} do
      book =
        book(author_id: author.id, category_id: category.id)
        |> generate()

      loaded_book = Ash.load!(book, :author)

      assert author.name == loaded_book.author.name
    end

    test "failed: creating book with invalid author" do
      assert_raise(Ash.Error.Invalid, fn ->
        book(author_id: nil)
        |> generate()
      end)
    end
  end
end
