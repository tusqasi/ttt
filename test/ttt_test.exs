defmodule TttTest do
  use ExUnit.Case
  doctest Ttt

  test "Checks si" do
    assert Ttt.hello() == :world
  end
end
