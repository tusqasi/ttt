defmodule Ttt.Cli do
  def start() do
    # take input from player one
    show_board(%Ttt{})
    IO.puts("Started Tic-Tac-Toe")
    {:ok, pid} = GenServer.start_link(Ttt, [nil], name: Ttt)

    play(:p1)
  end

  def play(:p1) do
    player1_input = get_input("p1")

    GenServer.call(Ttt, {:player1_input, player1_input})
    |> Ttt.check_win()
    |> win_message()

    play(:p2)
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

  def play(:p2) do
    player2_input = get_input("p2")
    GenServer.call(Ttt, {:player2_input, player2_input})
    play(:p1)
  end

  def show_board(board) do
    IO.inspect(board)
  end

  def show_idx(board) do
    IO.puts("1 2 3")
    IO.puts("4 5 6")
    IO.puts("7 8 9")
  end

  def get_input(player_id) do
    IO.gets("#{player_id} >")
    |> String.trim()
    |> String.to_integer()
  end
end
