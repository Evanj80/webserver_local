#Basic Router module that can decide which messages to transmit based on HTTP link
defmodule Hackathon.Router do
    use Plug.Router
    import Jason
    alias Hackathon.Blink
    alias Hackathon.Savestate
    alias Hackathon.LedManager
    #Implement plug interface
    plug(:match)
    plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json"],
                       json_decoder: Jason
    plug(:dispatch)

    #waits for a request with the http//...:8080/blink
    get "/blink" do
      IO.inspect("Someone is accessing the server")
      # x = IO.inspect conn.body_params
      # y = Map.get(conn.body_params, "message")|> IO.inspect
      LedManager.set(:blink)
      |> IO.inspect(label: "This is thr blink.sustained process inspection")
      #send_resp(conn, 200, "Pinged\n Your Username is #{x["username"]}\n Your Password is #{x["password"]}\n")
      send_resp(conn, 200, "The Raspberry Pi is responding and has begun to blink\n")
    end 
    #waits for a request with the http//...:8080/on
    get "/on" do
      IO.inspect("Somoone wants to know if I can see this")
      LedManager.set(:on)
      |> IO.inspect(label: "This is thes blink.start process inspection")
      send_resp(conn, 200, "The Raspberry Pi is responding and has turned the light on\n")
    end
    #waits for a request with the http//...:8080/cycle
    get "/cycle" do
      IO.inspect "Someone wants the LED to cycle throw patterns"
      LedManager.cycle()
      send_resp(conn, 200, "The Raspberry pi sucessfully cycled the light")
    end

    #waits for a request that does not match any other get links
    match _ do
      IO.inspect("Someone is communicating using an invalid HTTP")
      LedManager.set(:off)
       send_resp(conn, 404, "Cannot communicate a message, thus the light has been shut off\n")
    end 

    
end