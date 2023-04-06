defmodule TttTest do
  use ExUnit.Case
  doctest Ttt

  test "Check 2 win conditions" do
    assert Ttt.check_win(%{
             1 => 2,
             2 => 1,
             3 => -1,
             4 => -1,
             5 => 1,
             6 => -1,
             7 => 2,
             8 => 2,
             9 => 2
           }) == 2
  end

  test "Check 1 win conditions" do
    assert Ttt.check_win(%{
             1 => 1,
             2 => 1,
             3 => 1,
             4 => -1,
             5 => 1,
             6 => -1,
             7 => -1,
             8 => 1,
             9 => -1
           }) == 1
  end

  test "Check no win conditions" do
    assert Ttt.check_win(%{
             1 => 1,
             2 => 2,
             3 => 1,
             4 => -1,
             5 => 1,
             6 => -1,
             7 => -1,
             8 => 2,
             9 => -1
           }) == nil
  end

  test "Check winning conditions" do
    boards = %{
      %{
        1 => 1,
        2 => -1,
        3 => 2,
        4 => 2,
        5 => 2,
        6 => -1,
        7 => 1,
        8 => 1,
        9 => 1
      } => 1,
      %{
        1 => 2,
        2 => 2,
        3 => 2,
        4 => 1,
        5 => -1,
        6 => -1,
        7 => 1,
        8 => 2,
        9 => 2
      } => 2,
      %{
        1 => 2,
        2 => -1,
        3 => 1,
        4 => 1,
        5 => 1,
        6 => -1,
        7 => 2,
        8 => -1,
        9 => 2
      } => nil
    }

    boards
    |> Enum.map(fn {board, winner} ->
      Ttt.check_win(board) == winner
    end)
  end
end
