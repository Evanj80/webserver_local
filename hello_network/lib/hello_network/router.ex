
#Basic Router module that can decide which messages to transmit based on HTTP link
defmodule HelloNetwork.Router do
    use Plug.Router
    import Jason
    alias HelloNetwork.Blink
    alias HelloNetwork.Savestate
    #SaveState.start_state()
    plug(:match)
     plug Plug.Parsers, parsers: [:json],
                       pass: ["application/json"],
                       json_decoder: Jason
    plug(:dispatch)

    get "/blink" do
      IO.inspect("Someone is accessing the server")
      # x = IO.inspect conn.body_params
      # y = Map.get(conn.body_params, "message")|> IO.inspect
      IO.inspect(Blink.start(nil,nil,2), label: "This is thr blink.sustained process inspection")
      #send_resp(conn, 200, "Pinged\n Your Username is #{x["username"]}\n Your Password is #{x["password"]}\n")
      send_resp(conn, 200, "The Raspberry Pi is responding and has begun to blink\n")
    end 

    get "/on" do
      IO.inspect("Somoone wants to know if I can see this")
      IO.inspect(Blink.start(nil,nil,0), label: "This is thes blink.start process inspection")
      send_resp(conn, 200, "The Raspberry Pi is responding and has turned the light on\n")
    end

    get "/cycle" do
      IO.inspect "Someone wants the LED to cycle throw patterns"
      if(Savestate.get()+1 >2) do
        Savestate.update(-1)
      end
      Blink.start(nil,nil,Savestate.get()+1)
    end


    match _ do
      IO.inspect("Someone is communicating using an invalid HTTP")
      Blink.start(true,true,1)
      send_resp(conn, 404, "Cannot communicate a message, thus the light has been shut off\n")
    end 

    
end