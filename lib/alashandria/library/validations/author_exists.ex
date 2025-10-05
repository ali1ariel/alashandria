defmodule Alashandria.Library.Validations.AuthorExists do
  alias Alashandria.Library.Catalog.Author
  alias Alashandria.Library.Catalog
  use Ash.Resource.Validation

  def validate(changeset, _opts, _context) do
    author_id = Ash.Changeset.get_attribute(changeset, :author_id)

    case Ash.get(Author, author_id, domain: Catalog) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, field: :author_id, message: "Author does not exist"}
    end
  end
end
