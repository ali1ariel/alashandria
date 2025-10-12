defmodule Alashandria.Circulation.Generators do
  alias Alashandria.Catalog.Generators, as: CatalogGenerators
  alias Alashandria.Library.Circulation.Reserve
  use Ash.Generator

  def reserve(opts \\ []) do

    book_id = opts[:book_id] || once(:default_book_id, fn -> generate(CatalogGenerators.book()).id end)


    changeset_generator(
      Reserve,
      :create,
      defaults: [
        book_id: book_id
      ],
      overrides: opts
    )
  end

end
