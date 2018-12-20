defmodule Networkcom.Application do


  use Application
  require Logger

  def start(_type, _args) do
    # List all child processes to be supervised
    #Decides Cowboy and Router module are supervised
    children = [
      {Plug.Cowboy, scheme: :http, plug: Networkcom.Router, options: [port: 8080]}
    ]
    opts = [strategy: :one_for_one, name: Networkcom.Supervisor]

    Logger.info("starting application....")
    SaveState.start_link(nil)


    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Networkcom.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
