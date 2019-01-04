defmodule HelloNetwork.HostApplication do


    use Application
    require Logger
  
    def start(_type, _args) do

      HelloNetwork.Setup.setup()

    end
  end
  