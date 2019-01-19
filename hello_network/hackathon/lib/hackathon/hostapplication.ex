defmodule Hackathon.HostApplication do

    #start function set up for host machine
        use Application
        require Logger
      
        def start(_type, _args) do
    
          Hackathon.Setup.setup()
    
        end
      end
      