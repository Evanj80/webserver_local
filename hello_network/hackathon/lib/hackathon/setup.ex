defmodule Hackathon.Setup do

    require Logger
  
      def setup do
          Hackathon.LedManager.start_link(0)
  
          setupplug()
      end
  
      def setupplug() do
          # List all child processes to be supervised
            #Decides Cowboy and Router module are supervised
            children = [
              {Plug.Cowboy, scheme: :http, plug: Hackathon.Router, options: [port: 8080]}
            ]
            opts = [strategy: :one_for_one, name: Hackathon.Supervisor]
        
            Logger.info("starting application....")
        
        
            # See https://hexdocs.pm/elixir/Supervisor.html
            # for other strategies and supported options
            opts = [strategy: :one_for_one, name: Hackathon.Supervisor]
            Supervisor.start_link(children, opts)
          
        end
  end