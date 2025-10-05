defmodule Alashandria.Application do
  use Application

  def start(_type, _args) do
    setup_mnesia()

    children = [
      {Bandit, plug: Alashandria.Endpoint, port: 4000}
    ]

    opts = [strategy: :one_for_one, name: Alashandria.Supervisor]

    Supervisor.start_link(children, opts)
  end

  defp setup_mnesia do
    :mnesia.create_schema([node()])
    Ash.DataLayer.Mnesia.start(Alashandria.Library.Catalog)
  end
end
