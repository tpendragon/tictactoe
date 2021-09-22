defmodule TictactoeWeb.GameLive do
  use TictactoeWeb, :live_view

  def mount(_, _, socket) do
    socket = socket |> update_board
    BoardState.subscribe()
    {:ok, socket}
  end

  def handle_info(%{event: "board_updated"}, socket) do
    socket = socket |> update_board
    { :noreply, socket }
  end

  def update_board(socket) do
    board_state = BoardState.get_board()
    socket
    |> assign(:board_state, board_state)
  end
end
