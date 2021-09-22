defmodule TictactoeWeb.Game.GameComponent do
  use TictactoeWeb, :live_component

  def handle_event("select_square", %{"column" => column, "row" => row }, socket = %{assigns: %{ board_state: %{board: board, turn: turn, winner: false}}}) do
    BoardState.set_position(row, column, turn)
    {:noreply, socket}
  end

  def handle_event("select_square", _value, socket), do: {:noreply, socket}

  def handle_event("reset", _value, socket) do
    BoardState.reset()
    { :noreply, socket }
  end

end
