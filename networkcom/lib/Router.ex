
#Basic Router module that can decide which messages to transmit based on HTTP link
defmodule Networkcom.Router do
    use Plug.Router
    import Jason

    plug(:match)
     plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json"],
                       json_decoder: Jason
    plug(:dispatch)

    post "/ping" do
      IO.inspect("Someone is accessing the server")
      x = IO.inspect conn.body_params
      send_resp(conn, 200, "Pinged\n Your Username is #{x["username"]}\n Your Password is #{x["password"]}\n")
    end 
    
    match _ do
      IO.inspect("Someone is communicating using an invalid HTTP")
      send_resp(conn, 404, "Cannot communicate a message\n")
    end 

    
end