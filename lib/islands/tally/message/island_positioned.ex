defmodule Islands.Tally.Message.IslandPositioned do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Tally.{Island, Point}
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(_player_id, %Tally{
        request: {:position_island, _gamer_id, island_type, row, col}
      }) do
    [
      :dark_green_background,
      :light_white,
      "#{Island.format(island_type)} positioned at #{Point.format(row, col)}."
    ]
  end
end
