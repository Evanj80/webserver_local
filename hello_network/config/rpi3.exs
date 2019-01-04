# Configuration for the Raspberry Pi 3 (target rpi3)
use Mix.Config

Application.put_env(:hello_network, :led_api, Nerves.Leds)

config :hello_network, led_list: [:green]
config :nerves_leds, names: [green: "led0"]