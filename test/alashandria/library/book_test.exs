defmodule Alashandria.Library.Catalog.BookTest do
  use ExUnit.Case, async: false

  use Alashandria.Generator

  setup do
    %{author: generate(author())}
  end

  describe "creating books" do
    test "creating book with valid author", %{author: author} do
      book =
        book(author_id: author.id)
        |> generate()

      loaded_book = Ash.load!(book, :author)

      assert author.name == loaded_book.author.name
    end

    test "creating book with invalid author" do
      assert_raise(Ash.Error.Invalid, fn ->
        book(author_id: nil)
        |> generate()
      end)
    end
  end
end
