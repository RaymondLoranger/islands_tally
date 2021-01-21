defmodule Islands.Tally.Message.IslandsSet do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(player_id, %Tally{request: {:set_islands, player_id}}) do
    [
      :dark_green_background,
      :light_white,
      "Islands set."
    ]
  end

  def message(_player_id, %Tally{request: {:set_islands, _gamer_id}}) do
    [
      :dark_green_background,
      :light_white,
      "Opponent's islands set."
    ]
  end
end
