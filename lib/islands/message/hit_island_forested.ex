defmodule Islands.Tally.Message.HitIslandForested do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Tally.{Island, Point}
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(player_id, %Tally{
        request: {:guess_coord, player_id, row, col},
        response: {:hit, island_type, _win_status}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Your guess #{Point.format(row, col)} ",
      "➔ #{Island.format(island_type)} forested."
    ]
  end

  def message(_player_id, %Tally{
        request: {:guess_coord, _gamer_id, row, col},
        response: {:hit, island_type, _win_status}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Opponent's guess #{Point.format(row, col)} ",
      "➔ #{Island.format(island_type)} forested."
    ]
  end
end
