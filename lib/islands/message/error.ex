defmodule Islands.Tally.Message.Error do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(_player_id, %Tally{response: {:error, reason}}) do
    [
      :free_speech_red_background,
      :light_white,
      "ERROR: #{Atom.to_string(reason) |> String.replace("_", " ")}."
    ]
  end
end
