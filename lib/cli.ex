defmodule Ttt.Cli do
  @next_player %{
    p1: :p2,
    p2: :p1
  }
  def main() do
    start()
  end

  def start() do
    # take input from player one
    show_board(%Ttt{})
    IO.puts("Started Tic-Tac-Toe")
    GenServer.start_link(Ttt, [nil], name: Ttt)
    receive_command(:p1)
  end

  def receive_command(player) do
  IO.inspect(player)
    input =
      IO.gets("#{player} > ")
      |> String.trim()
      |> String.to_integer()

    cond do
      input > 0 and input <= 9 ->
        play(input, player)

      input < 0 and input > 9 ->
        IO.puts("Input should be in between 1 and 9")
        receive_command(player)

      true ->
        IO.puts("Invalid Input")
        receive_command(player)
    end
  end

  def play(player, input) do
    IO.inspect(player)

    GenServer.call(Ttt, {player, input})
    |> Ttt.check_win()
    |> win_message()

    receive_command(Map.get(@next_player, player))
  end

  def win_message(1) do
    IO.puts("Player one wins")
  end

  def win_message(2) do
    IO.puts("Player two wins")
  end

  def win_message(nil) do
    nil
  end

  def show_board(board) do
    IO.inspect(board)
  end

  def show_idx() do
    IO.puts("1 2 3")
    IO.puts("4 5 6")
    IO.puts("7 8 9")
  end
end
