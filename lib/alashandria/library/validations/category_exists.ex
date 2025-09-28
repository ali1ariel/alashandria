defmodule Alashandria.Library.Validations.CategoryExists do
  alias Alashandria.Library.Category
  use Ash.Resource.Validation

  def validate(changeset, _opts, _context) do
    category_id = Ash.Changeset.get_attribute(changeset, :category_id)

    case Ash.get(Category, category_id, domain: Alashandria.Library) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, field: :category_id, message: "Category does not exist"}
    end
  end
end
