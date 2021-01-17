defmodule Islands.Tally.Message.AllIslandsPositioned do
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
      "#{Island.format(island_type)} positioned at #{Point.format(row, col)}. ",
      "ALL ISLANDS POSITIONED."
    ]
  end

  def message(_player_id, %Tally{
        request: {:position_all_islands, _gamer_id}
      }) do
    [
      :dark_green_background,
      :light_white,
      "ALL ISLANDS POSITIONED."
    ]
  end
end
