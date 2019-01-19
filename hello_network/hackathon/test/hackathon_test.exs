defmodule HackathonTest do
  use ExUnit.Case
  doctest Hackathon

  test "greets the world" do
    assert Hackathon.hello() == :world
  end
end
