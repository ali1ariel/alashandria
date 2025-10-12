defmodule Alashandria.Generator do
  defmacro __using__(_opts) do
    quote do
      import Alashandria.Catalog.Generators, except: [generate: 1, generate_many: 2]
      import Alashandria.Circulation.Generators, except: [generate: 1, generate_many: 2]
      use Ash.Generator
    end
  end
end
