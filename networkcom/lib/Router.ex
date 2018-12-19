
#Basic Router module that can decide which messages to transmit base on HTTP link
defmodule Networkcom.Router do
    use Plug.Router

    plug(:match)
    plug(:dispatch)

    get("/ping", do: send_resp(conn, 200, "Pinged\n"))
    match(_, do: send_resp(conn, 404, "Cannot communicate a message"))
end