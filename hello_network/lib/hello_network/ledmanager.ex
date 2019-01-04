defmodule HelloWorld.Ledmanager do

    def start_link(value) do
        Agent.start_link)(fn [{_a,[]} -> value], label: __MODULE__)
    end

    def cycle() do
        cycle_internal()

    end

    def set(value) do
        set_internal(__MODULE__, value)

    end

    defp set_internal(pid, value) do
        Agent.update(pid, fn value -> value end )
    end

    defp cycle_internal() do
    end

    defp ledtask() do
    
        Process.sleep(50)
    end