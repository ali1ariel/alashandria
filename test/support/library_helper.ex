defmodule Alashandria.LibraryHelper do
  alias Alashandria.Library
  alias Alashandria.Library.{Author, Book}

  def create_author(attrs) do
    Author
    |> Ash.Changeset.for_create(:create, attrs)
    |> Ash.create!(domain: Library)
  end

  def create_book(attrs, author_id) do
    attrs = Map.put(attrs, :author_id, author_id)

    Book
    |> Ash.Changeset.for_create(:create, attrs)
    |> Ash.create!(domain: Library)
  end

  def create_book_with_author(book_attrs, author_attrs) do
    author = create_author(author_attrs)
    create_book(book_attrs, author.id)
  end

  def list_authors do
    Author
    |> Ash.read()
  end
end
