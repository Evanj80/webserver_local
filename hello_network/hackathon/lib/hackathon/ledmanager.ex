defmodule HelloNetwork.LedManager do


    @led Application.get_env(:hello_network, :led_api)
    @led_list Application.get_env(:hello_network, :led_list)
    #Creates the Agent that will control the state of LED
    def start_link(value) do
        Agent.start_link(fn -> :off end, name: __MODULE__) |> IO.inspect(label: "Start link")
    end
    #Cycles through the different LED modes
    def cycle() do
        Agent.update(__MODULE__,fn state -> cycle_internal(state) end) |> IO.inspect(label: "cycle")

    end
    #Sets the LED to one of the three modes. Takes in a value of :on,:off,:blink
    def set(value) do
        IO.inspect(value, label: "value")
        Agent.update(__MODULE__, fn _state -> 
            IO.inspect(label: "before set internal")
           set_internal(value) 
        end) |> IO.inspect

    end
    #Called with the Agent call of update, is used to change state of LED and report back what its new state is
    defp set_internal(value) do
        IO.inspect(value, label: "set_internal value")
        ledtask(@led_list,value) |> IO.inspect(label: "led task returned")
    end
    #Takes current state, changes the state using next_state(), then sends it the new state to set_internal
    defp cycle_internal(state) do
       state
       |> next_state
       |> set_internal
    end
    # All of these methods set new state based upon previous state
    defp next_state(:on), do: :blink
    defp next_state(:blink), do: :off
    defp next_state(:off), do: :on
    

    #Controls exactly what the LED is doing in terms of ON, OFF, BLINKING
    defp ledtask([led_key], value) do
    IO.inspect(led_key, label: "Ledkey")
    IO.inspect(value, label: "value in ledtask")
        case value do
          #All of these @led refer to either green or fake depeneding upon target defined within config
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