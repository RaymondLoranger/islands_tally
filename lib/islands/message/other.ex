defmodule Islands.Tally.Message.Other do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(_player_id, %Tally{response: response, request: request}) do
    [
      :dark_green_background,
      :light_white,
      "Unknown response...",
      :reset,
      "\n#{inspect(request)} ➔ #{inspect(response)}"
    ]
  end
end
