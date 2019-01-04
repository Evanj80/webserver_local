defmodule HelloNetwork.LedManager do


    @led Application.get_env(:hello_network, :led_api)
    @led_list Application.get_env(:hello_network, :led_list)

    def start_link(value) do
        Agent.start_link(fn -> :off end, name: __MODULE__) |> IO.inspect(label: "Start link")
    end

    def cycle() do
        Agent.update(__MODULE__,fn state -> cycle_internal(state) end) |> IO.inspect(label: "cycle")

    end

    def set(value) do
        IO.inspect(value, label: "value")
        Agent.update(__MODULE__, fn _state -> 
            IO.inspect(label: "before set internal")
           set_internal(value) 
        end) |> IO.inspect

    end

    defp set_internal(value) do
        IO.inspect(value, label: "set_internal value")
        ledtask(@led_list,value) |> IO.inspect(label: "led task returned")
    end

    defp cycle_internal(state) do
       state
       |> next_state
       |> set_internal
    end

    defp next_state(:on), do: :blink
    defp next_state(:blink), do: :off
    defp next_state(:off), do: :on

    defp ledtask([led_key], value) do
    IO.inspect(led_key, label: "Ledkey")
    IO.inspect(value, label: "value in ledtask")
        case value do
              :on -> IO.inspect(@led, label: "hello")
              @led.set([
                {
                led_key,
                [
                  trigger: "none"
                ]
              }]) |> IO.inspect(label: "1")         
              @led.set([
                {
          
                  led_key,
                  [
                    brightness: "1"
                  ]
                }
              ]) |> IO.inspect(label: "2")   
            :off -> @led.set([
                {
                led_key,
                [
                  trigger: "none"
                ]
              }])
              @led.set([
                {
          
                  led_key,
                  [
                    brightness: "0"
                  ]
                }
              ])  
            :blink -> @led.set([
                {
          
                  led_key,
                  [
                    trigger: "timer",
                    delay_off: 200,
                    delay_on: 200
                  ]
                }
              ])  
            end |> IO.inspect(label: "case statement")
        value        
    end
end