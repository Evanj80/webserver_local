defmodule NetworkcomTest do
  use ExUnit.Case

  SaveState.start_link(nil)

  test "SaveState clear state is nil" do
    SaveState.clear()
  
    assert nil = SaveState.get()
  end

  test "SaveState can store state" do

    SaveState.clear()
  
    SaveState.set("foo")
  
    assert "foo" = SaveState.get()
  
  end

  test "SaveState can store a dif state" do

    SaveState.clear()
  
    SaveState.set(34)
  
    assert 34 = SaveState.get()
  end

  test "SaveState Sets itself twice" do

    SaveState.clear()
  
    SaveState.set(34)
  
    SaveState.set("Evan")

    assert "Evan" = SaveState.get()
  end

  test "SaveState stores a value and then resets" do

  
    SaveState.set(34)

    SaveState.clear()
  
    assert nil = SaveState.get()
  end



end
  