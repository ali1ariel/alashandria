defmodule Alashandria.Schema do
  use Absinthe.Schema

  use AshGraphql, domains: [Alashandria.Library.Catalog]

  query do
  end

  mutation do
  end
end
