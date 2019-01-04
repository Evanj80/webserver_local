defmodule HelloNetwork.Setup do

  require Logger

    def setup do
        HelloNetwork.LedManager.start_link(0)

        setupplug()
    end

    def setupplug() do
        # List all child processes to be supervised
          #Decides Cowboy and Router module are supervised
          children = [
            {Plug.Cowboy, scheme: :http, plug: HelloNetwork.Router, options: [port: 8080]}
          ]
          opts = [strategy: :one_for_one, name: HelloNetwork.Supervisor]
      
          Logger.info("starting application....")
      
      
          # See https://hexdocs.pm/elixir/Supervisor.html
          # for other strategies and supported options
          opts = [strategy: :one_for_one, name: HelloNetwork.Supervisor]
          Supervisor.start_link(children, opts)
        
      end
end