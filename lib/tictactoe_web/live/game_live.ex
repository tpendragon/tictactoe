defmodule TictactoeWeb.GameLive do
  use TictactoeWeb, :live_view

  def mount(_params, _session, socket) do
    socket = socket |> update_board
    {:ok, socket}
  end

  def handle_event("select_square", %{"column" => column, "row" => row }, socket = %{assigns: %{board: board, turn: turn, winner: false}}) do
    BoardState.set_position(row, column, turn)
    socket = socket |> update_board
    {:noreply, socket}
  end

  def handle_event("select_square", _value, socket), do: {:noreply, socket}

  def handle_event("reset", _value, socket) do
    BoardState.reset()
    socket = socket |> update_board
    { :noreply, socket }
  end

  def update_board(socket) do
    board_state = BoardState.get_board()
    socket
    |> assign(:board, board_state.board)
    |> assign(:turn, board_state.turn)
    |> assign(:winner, board_state.winner)
  end

end
