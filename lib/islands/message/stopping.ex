defmodule Islands.Tally.Message.Stopping do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID, Tally.t()) :: ANSI.ansilist()
  def message(_player_id, %Tally{request: {:stop, _gamer_id}}) do
    [
      :dark_green_background,
      :light_white,
      "Stopping the game..."
    ]
  end
end
