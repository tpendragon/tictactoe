defmodule BoardState do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> initial_state()  end, name: __MODULE__)
  end

  def subscribe() do
    Phoenix.PubSub.subscribe(Tictactoe.PubSub, "board_state")
  end

  def initial_board do
    %{
      "1" => %{ "1" => "", "2" => "", "3" => ""},
      "2" => %{ "1" => "", "2" => "", "3" => ""},
      "3" => %{ "1" => "", "2" => "", "3" => ""},
    }
  end

  def initial_state do
    %{ board: initial_board(), turn: "X", winner: false }
  end

  def get_board do
    Agent.get(__MODULE__, & &1)
  end

  def set_position(row, column, value) do
    Agent.update(__MODULE__, fn state ->
      if get_in(state.board, [row, column]) == "" do
        board = state.board |> put_in([row, column], value)
        state
        |> Map.put(:board, board)
        |> Map.put(:turn, Board.next_turn(state.turn))
        |> Map.put(:winner, Board.winning_board(board))
      else
        state
      end
    end)
    broadcast_change
  end

  def reset do
    Agent.update(__MODULE__, fn _state -> initial_state() end)
    broadcast_change
  end

  def broadcast_change do
    Phoenix.PubSub.broadcast(Tictactoe.PubSub, "board_state", %{event: "board_updated"})
  end

end
