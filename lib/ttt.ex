defmodule Ttt do
  defstruct board: %{
              1 => -1,
              2 => -1,
              3 => -1,
              4 => -1,
              5 => -1,
              6 => -1,
              7 => -1,
              8 => -1,
              9 => -1
            }

  use GenServer

  @doc """
  A Tic-Tac-Toe server to save games state
  """

  @impl true
  def init(_init_arg) do
    {:ok, %Ttt{}}
  end

  @impl true
  def handle_call({:show_board}, _from, board) do
    {:reply, {:ok, board}, board}
  end

  @impl true
  def handle_call({player, input}, _from, board) when is_atom(player) and is_integer(input) do
    ## if board at input is -1,  put input and p1 at input
    ## if win, return win
    ## Done
    cond do
      # The position at which player wants to put the cross/nought is empty
      Map.get(board.board, input) == -1 ->
        {:reply, {:ok, board}, %Ttt{board: %{board.board | input => player}}}

      # The position isn't empty and occupied
      true ->
        {:reply, {:not_empty, board}, board}
    end
  end

  @spec check_win(%Ttt{}) :: atom()
  def check_win(%Ttt{board: board}) do
    if not Enum.any?(board, fn {_, player} -> player == -1 end) do
      :draw
    else
      case board do
        %{1 => 1, 2 => 1, 3 => 1, 4 => _, 5 => _, 6 => _, 7 => _, 8 => _, 9 => _} ->
          :p1

        %{1 => _, 2 => _, 3 => _, 4 => 1, 5 => 1, 6 => 1, 7 => _, 8 => _, 9 => _} ->
          :p1

        %{1 => _, 2 => _, 3 => _, 4 => _, 5 => _, 6 => _, 7 => 1, 8 => 1, 9 => 1} ->
          :p1

        %{1 => 1, 2 => _, 3 => _, 4 => 1, 5 => _, 6 => _, 7 => 1, 8 => _, 9 => _} ->
          :p1

        %{1 => _, 2 => 1, 3 => _, 4 => _, 5 => 1, 6 => _, 7 => _, 8 => 1, 9 => _} ->
          :p1

        %{1 => _, 2 => _, 3 => 1, 4 => _, 5 => _, 6 => 1, 7 => _, 8 => _, 9 => 1} ->
          :p1

        %{1 => 1, 2 => _, 3 => _, 4 => _, 5 => 1, 6 => _, 7 => _, 8 => _, 9 => 1} ->
          :p1

        %{1 => _, 2 => _, 3 => 1, 4 => _, 5 => 1, 6 => _, 7 => 1, 8 => _, 9 => _} ->
          :p1

        %{1 => 2, 2 => 2, 3 => 2, 4 => _, 5 => _, 6 => _, 7 => _, 8 => _, 9 => _} ->
          :p2

        %{1 => _, 2 => _, 3 => _, 4 => 2, 5 => 2, 6 => 2, 7 => _, 8 => _, 9 => _} ->
          :p2

        %{1 => _, 2 => _, 3 => _, 4 => _, 5 => _, 6 => _, 7 => 2, 8 => 2, 9 => 2} ->
          :p2

        %{1 => 2, 2 => _, 3 => _, 4 => 2, 5 => _, 6 => _, 7 => 2, 8 => _, 9 => _} ->
          :p2

        %{1 => _, 2 => 2, 3 => _, 4 => _, 5 => 2, 6 => _, 7 => _, 8 => 2, 9 => _} ->
          :p2

        %{1 => _, 2 => _, 3 => 2, 4 => _, 5 => _, 6 => 2, 7 => _, 8 => _, 9 => 2} ->
          :p2

        %{1 => 2, 2 => _, 3 => _, 4 => _, 5 => 2, 6 => _, 7 => _, 8 => _, 9 => 2} ->
          :p2

        %{1 => _, 2 => _, 3 => 2, 4 => _, 5 => 2, 6 => _, 7 => 2, 8 => _, 9 => _} ->
          :p2

        _ ->
          :no_win
      end
    end
  end

  def is_draw(board) do
    not Enum.any?(board.board, fn {_, player} -> player == -1 end)
  end
end
