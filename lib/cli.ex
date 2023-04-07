defmodule Ttt.Cli do
  @next_player %{
    p1: :p2,
    p2: :p1
  }

  def start() do
    # take input from player one
    IO.puts("Started Tic-Tac-Toe")
    GenServer.start_link(Ttt, [nil], name: Ttt)
    show_board()
    receive_command(:p1)
  end

  def receive_command(player) do
    IO.inspect(player)

    case(get_command(player)) do
      {:show_board} ->
        show_board()

      {:ok, input} ->
        play(player, input)

      :error ->
        receive_command(player)
    end
  end

  def get_command(player) do
    input = IO.gets("#{player} > ") |> String.trim()

    cond do
      input == "b" ->
        :show_board

      input |> Integer.parse() != :error ->
        number = input |> String.to_integer()

        if number >= 1 and number <= 9, do: {:ok, number}, else: :error

      true ->
        :error
    end
  end

  def play(player, input) do
    with {:ok, board} <- GenServer.call(Ttt, {player, input}),
         :no_win <-
           Ttt.check_win(board) |> message do
      show_board()
      receive_command(Map.get(@next_player, player))
    else
      {:end, :draw} ->
        IO.puts("game ended")

      {:not_empty, board} ->
        if not Ttt.is_draw(board), do: receive_command(player)

      {:end, _} ->
        IO.puts("game ended")
    end

    # case GenServer.call(Ttt, {player, input}) do
    #   {:ok, board} ->
    #     case Ttt.check_win(board) |> message() do
    #       :no_win ->
    #         receive_command(Map.get(@next_player, player))
    #
    #       _ ->
    #         board
    #     end
    #
    #   {:not_empty, _} ->
    #     receive_command(player)
    # end
  end

  def message(:p1) do
    IO.puts("Player one wins")
    {:end, :p1}
  end

  def message(:p2) do
    IO.puts("Player two wins")
    {:end, :p2}
  end

  def message(:draw) do
    IO.puts("Game draw")
    {:end, :draw}
  end

  def message(:no_win) do
    :no_win
  end

  def show_board() do
    {:ok, board} = GenServer.call(Ttt, {:show_board})
    IO.inspect(board)
  end

  def show_idx() do
    IO.puts("1 2 3")
    IO.puts("4 5 6")
    IO.puts("7 8 9")
  end
end
