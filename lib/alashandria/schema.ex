defmodule Alashandria.Schema do
  use Absinthe.Schema

  use AshGraphql, domains: [Alashandria.Library.Catalog, Alashandria.Library.Circulation]

  query do
  end

  mutation do
  end
end
