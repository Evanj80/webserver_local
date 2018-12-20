defmodule SaveState do
    use Agent

    #Starts a new state that contains an empty map
    def start_link(_opts) do
        Agent.start_link(fn-> [] end ,name: __MODULE__)
    end

    def clear() do
        # unless Process.whereis(__MODULE__) do
        #     start_link(nil)
        # end
        Agent.update(__MODULE__,fn list -> [] end)
    end

    def set(a) do
        # unless Process.whereis(__MODULE__) do
        #     start_link(nil)
        # end
        Agent.update(__MODULE__, fn list -> [a | list] end)
    end

    def get() do
        Agent.get(__MODULE__, fn list -> list end)
    end
end
