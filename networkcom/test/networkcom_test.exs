defmodule NetworkcomTest do
  use ExUnit.Case

  test "SaveState clear state to []" do
    SaveState.clear()
  
    assert [] = SaveState.get()
  end

  test "SaveState can store state" do

    SaveState.clear()
  
    SaveState.set("foo")
  
    assert ["foo"] = SaveState.get()
  
  end

  test "SaveState can store a dif state" do

    SaveState.clear()
  
    SaveState.set(34)
  
    assert [34] = SaveState.get()
  end

  test "SaveState Sets itself twice" do

    SaveState.clear()
  
    SaveState.set(34)
  
    SaveState.set("Evan")

    assert ["Evan", 34] = SaveState.get()
  end

  test "SaveState stores a value and then resets" do

  
    SaveState.set(34)

    SaveState.clear()
  
    assert [] = SaveState.get()
  end



end
  