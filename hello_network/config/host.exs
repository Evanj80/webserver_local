# Configuration for the host (no LEDs to blink)
use Mix.Config

Application.put_env(:hello_network, :led_api, Mock.Led)
config :hello_network, led_list: [:fake]
config :nerves_leds, names: []