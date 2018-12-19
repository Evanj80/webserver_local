
#Basic Router module that can decide which messages to transmit base on HTTP link
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
      IO.inspect conn.body_parems
      send_resp(conn, 200, "Pinged\n")
    end 
    
    match _ do
        IO.inspect("Someone is communicating using an invalid HTTP")
      send_resp(conn, 404, "Cannot communicate a message\n")
    end 
end