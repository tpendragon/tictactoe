defmodule TictactoeWeb.GameLive do
  use TictactoeWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:board, initial_board())
      |> assign(:turn, "X")
      |> assign(:winner, false)
    {:ok, socket}
  end

  def handle_event("select_square", %{"column" => column, "row" => row }, socket = %{assigns: %{board: board, turn: turn, winner: false}}) do
    board = board |> put_in([row, column], turn)
    next_turn = next_turn(turn)
    socket =
      socket
      |> assign(:board, board)
      |> assign(:turn, next_turn(turn))
    if winning_board(board) do
      socket =
        socket
        |> assign(:winner, turn)
      {:noreply, socket}
    else
      {:noreply, socket}
    end
  end

  def handle_event("select_square", _value, socket), do: {:noreply, socket}

  def handle_event("reset", _value, socket) do
    socket =
      socket
      |> assign(:board, initial_board)
      |> assign(:turn, "X")
      |> assign(:winner, false)
    { :noreply, socket }
  end

  # Column win.
  def winning_board(%{"1" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(%{"2" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(%{"3" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: true
  # Row win
  def winning_board(%{"1" => %{"1" => x}, "2" => %{"1" => y}, "3" => %{"1" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(%{"1" => %{"2" => x}, "2" => %{"2" => y}, "3" => %{"2" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(%{"1" => %{"3" => x}, "2" => %{"3" => y}, "3" => %{"3" => z}}) when x == y and y == z and x != "", do: true
  # Diagonal Win
  def winning_board(%{"1" => %{"1" => x}, "2" => %{"2" => y}, "3" => %{"3" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(%{"1" => %{"3" => x}, "2" => %{"2" => y}, "3" => %{"1" => z}}) when x == y and y == z and x != "", do: true
  def winning_board(_), do: false

  def next_turn("X"), do: "O"
  def next_turn("O"), do: "X"

  def initial_board do
    %{
      "1" => %{ "1" => "", "2" => "", "3" => ""},
      "2" => %{ "1" => "", "2" => "", "3" => ""},
      "3" => %{ "1" => "", "2" => "", "3" => ""},
    }
  end
end
