defmodule HelloNetwork.HostApplication do

#start function set up for host machine
    use Application
    require Logger
  
    def start(_type, _args) do

      HelloNetwork.Setup.setup()

    end
  end
  