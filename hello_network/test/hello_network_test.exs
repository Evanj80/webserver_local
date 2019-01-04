defmodule HelloNetworkTest do
  use ExUnit.Case
  doctest HelloNetwork

  test "The light is going on" do
   HelloNetwork.Blink.start(nil,nil,0)
   
   
    assert 
  
  end
end
