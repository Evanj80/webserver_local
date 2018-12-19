defmodule PlugExample do
   use Application
   require Logger


   def start(_type, _args) do
     children = 
       Plug.Adapters.Cowboy.child_spec(:http, plug_example.Router, [], port: 8000)
   end

   Logger.info "App Started!"

   Supervisor.start_link(children, strategy: :one_for_one)
  end
end