defmodule Mock.Led do

    alias HelloNetwork.Savestate

    def set(_a) do
        #IO.inspect "The network request was processed correctly"
        IO.inspect Savestate.get() 
    end
   

end