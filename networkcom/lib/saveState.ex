defmodule saveState do
    use Agent

    #Starts a new state that contains an empty map
    def start_State(_opts) do
        Agent.start_link(fn-> %{} end)
    end

    #Grabs a value from the PID by using the key
    def get_State(pid, key) do
        Agent.get(pid, &Map.get(&1, key))
        
    #Puts the value for the given key into the bucket
    def put_State(pid, key value) do
        Agent.update(pid,&Map.put(&1,key,value))
    end
end