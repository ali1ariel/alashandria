defmodule Alashandria.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Bandit, plug: Alashandria.Endpoint, port: 4000}
    ]

    opts = [strategy: :one_for_one, name: Alashandria.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
