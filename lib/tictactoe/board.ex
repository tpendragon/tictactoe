defmodule Board do
  # Column win.
  def winning_board(%{"1" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(%{"2" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(%{"3" => %{"1" => x, "2" => y, "3" => z}}) when x == y and y == z and x != "", do: x
  # Row win
  def winning_board(%{"1" => %{"1" => x}, "2" => %{"1" => y}, "3" => %{"1" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(%{"1" => %{"2" => x}, "2" => %{"2" => y}, "3" => %{"2" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(%{"1" => %{"3" => x}, "2" => %{"3" => y}, "3" => %{"3" => z}}) when x == y and y == z and x != "", do: x
  # Diagonal Win
  def winning_board(%{"1" => %{"1" => x}, "2" => %{"2" => y}, "3" => %{"3" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(%{"1" => %{"3" => x}, "2" => %{"2" => y}, "3" => %{"1" => z}}) when x == y and y == z and x != "", do: x
  def winning_board(board) do
    board_entries =
      board
      |> Enum.reduce([], fn({_row, col}, acc) -> acc ++ Map.values(col) end)
    if Enum.member?(board_entries, "") do
      false
    else
      "Nobody"
    end
  end
  def winning_board(_), do: false

  def next_turn("X"), do: "O"
  def next_turn("O"), do: "X"

end
