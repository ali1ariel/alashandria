defmodule Alashandria.CategoryTest do
  use ExUnit.Case, async: false

  alias Alashandria.Library.Catalog.Category
  alias Alashandria.Library.Catalog
  # alias Ash.Domain

  use Alashandria.Generator
  import ExUnitProperties

  test "success: the category really wrote the books that he said" do
    category = generate(category())

    loaded_category = Ash.load!(category, :books)
    assert Enum.count(loaded_category.books) == 0

    generate_many(book(category_id: loaded_category.id), 10)

    new_loaded_category = Ash.load!(category, :books)
    assert Enum.count(new_loaded_category.books) == 10
  end

  test "failed: the changeset is not valid with invalid params" do
    changeset = Catalog.changeset_to_create_category(%{})

    Enum.map(changeset.errors, fn error ->
      case error do
        e = %Ash.Error.Changes.Required{} -> assert e.field == :name
      end
    end)

    refute changeset.valid?
  end

  property "success: category is created correctly with correct params" do
    check all(
            input <-
              Ash.Generator.action_input(Category, :create, %{
                name: StreamData.string(:alphanumeric, min_length: 2, max_length: 50),
              })
          ) do
      {:ok, category} = Catalog.create_category(input)

      assert category.name == input.name
    end
  end
end
