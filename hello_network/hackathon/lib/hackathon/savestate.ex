defmodule Hackathon.Savestate do
    def start_link(_opts) do
        Agent.start_link(fn -> 0 end, name: __MODULE__)
 
    end

    def get() do
        Agent.get(__MODULE__, fn state -> 
            Process.sleep(100)
            state end)
    end

    def update(value) do
        Agent.update(__MODULE__,fn state -> value end) 
        
    end
end