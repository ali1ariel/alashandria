defmodule Alashandria.Generator do
  use Ash.Generator
  defdelegate book(opts \\ []), to: Alashandria.Catalog.Generators
  defdelegate author(opts \\ []), to: Alashandria.Catalog.Generators
  defdelegate category(opts \\ []), to: Alashandria.Catalog.Generators
end
