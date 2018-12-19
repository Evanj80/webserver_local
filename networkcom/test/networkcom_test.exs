defmodule NetworkcomTest do
  use ExUnit.Case
  doctest Networkcom

  test "greets the world" do
    assert Networkcom.hello() == :world
  end
end
