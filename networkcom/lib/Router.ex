
#Basic Router module that can decide which messages to transmit based on HTTP link
defmodule Networkcom.Router do
    use Plug.Router
    import Jason
    #SaveState.start_state()
    plug(:match)
     plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json"],
                       json_decoder: Jason
    plug(:dispatch)

    post "/ping" do
      IO.inspect("Someone is accessing the server")
      x = IO.inspect conn.body_params
      y = Map.get(conn.body_params, "message")|> IO.inspect
      IO.inspect( "The saved state is #{y}")
      SaveState.set(y) 
      send_resp(conn, 200, "Pinged\n Your Username is #{x["username"]}\n Your Password is #{x["password"]}\n")
    end 

    get "/savedstate" do
      IO.inspect("Somoone is requesting the stored state")
      z = SaveState.get()
      send_resp(conn, 200, "The saved state that you have requested is: #{inspect z}\n")
    end
    
    match _ do
      IO.inspect("Someone is communicating using an invalid HTTP")
      send_resp(conn, 404, "Cannot communicate a message\n")
    end 

    
end