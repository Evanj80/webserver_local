defmodule SaveState do
    use Agent

    #Starts a new state that contains an empty map
    def start_link(_opts) do
        Agent.start_link(fn-> nil end ,name: __MODULE__)
    end

    def clear() do

        Agent.update(__MODULE__,fn list -> nil end)
    end

    def set(a) do

        Agent.update(__MODULE__, fn list -> [a | list] end)
    end

    def get() do

        Agent.get(__MODULE__, fn list -> list end)
    end
end