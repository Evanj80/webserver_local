defmodule HelloNetwork.Blink do

  alias HelloNetwork.Savestate
    
    @led Application.get_env(:hello_network, :led_api)
    require Logger
    
    #Old way of controling light using savestate function
    def start(_type, _args, choice) do     

      led_list = Application.get_env(:hello_network, :led_list)
      IO.inspect(led_list, label: "This is the led we are looking at(Should be empty if one host machine)")
      Logger.debug("list of leds to blink is #{inspect(led_list)}")
    if(choice == 0) do
        Savestate.update(choice)  #Save the state of choice
        IO.inspect("we are in the start blink conditional")
        IO.inspect(led_list, label: "The LED we are looking at")
        Enum.each(led_list, (&start_blink(&1))) |> IO.inspect(label: "Enum statement")
    end
    if(choice == 1) do
      IO.inspect(Savestate.update(choice), label: "Updating the state")  #Save the state of choice
      IO.inspect("we are in the stop blink conditional")
      Enum.each(led_list, &stop_blink(&1))
    end
    if(choice == 2) do
      Savestate.update(choice) #Save the state of choice 
      Enum.each(led_list, &sustained_blink(&1))
    end
    {:ok, self()}

  end

  # Set led `led_key` to the state defined below. It is also possible
  # to globally define states in `config/config.exs` by passing a list
  # of states with the `:states` keyword.
  #
  # The first parameter must be an atom.
  @spec start_blink(Keyword.T) :: true
  defp start_blink(led_key) do
    Logger.debug("blinking led #{inspect(led_key)}")
    # led_key is a variable that contains an atom
    IO.inspect "LED is about to be set"
    @led.set([
      {
      led_key,
      [
        trigger: "none"
      ]
    }])
   Process.sleep(50)

    @led.set([
      {

        led_key,
        [
          brightness: "1"
        ]
      }
    ])  

    IO.inspect "LED is on"

  end

  @spec stop_blink(Keyword.T) :: true

  defp stop_blink(led_key) do
    Logger.debug("blinking led #{inspect(led_key)}")
    # led_key is a variable that contains an atom
    @led.set([
      {
      led_key,
      [
        trigger: "none"
      ]
    }])
   Process.sleep(50)
    @led.set([
      {

        led_key,
        [
          brightness: "0"
        ]
      }
    ])  

  end

  @spec sustained_blink(Keyword.T) :: true
  defp sustained_blink(led_key) do
    Logger.debug("blinking led #{inspect(led_key)}")
    # led_key is a variable that contains an atom
    
    @led.set([
      {

        led_key,
        [
          trigger: "timer",
          delay_off: 200,
          delay_on: 200
        ]
      }
    ])  

  end

end
  