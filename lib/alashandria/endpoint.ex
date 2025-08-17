defmodule Alashandria.Endpoint do
  use Plug.Builder

  plug(Plug.Logger)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(Absinthe.Plug, schema: Alashandria.Schema)
end
