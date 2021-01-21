defmodule Islands.Tally.Message.HitNoneForested do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.Tally.Point
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(player_id, %Tally{
        request: {:guess_coord, player_id, row, col}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Your guess #{Point.format(row, col)} ➔ hit."
    ]
  end

  def message(_player_id, %Tally{
        request: {:guess_coord, _gamer_id, row, col}
      }) do
    [
      :dark_green_background,
      :light_white,
      "Opponent's guess #{Point.format(row, col)} ➔ hit."
    ]
  end
end
