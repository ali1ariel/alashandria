defmodule Alashandria.Generator do
  defmacro __using__(_opts) do
    quote do
      import Alashandria.Catalog.Generators
    end
  end
end
