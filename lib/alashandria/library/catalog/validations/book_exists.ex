defmodule Alashandria.Library.Catalog.Validations.BookExists do
  alias Alashandria.Library.Catalog.Book
  alias Alashandria.Library.Catalog
  use Ash.Resource.Validation

  def validate(changeset, _opts, _context) do
    book_id = Ash.Changeset.get_attribute(changeset, :book_id)

    case Ash.get(Book, book_id, domain: Catalog) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, field: :book_id, message: "Book does not exist"}
    end
  end
end
