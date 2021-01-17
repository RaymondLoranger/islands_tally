defmodule Islands.Tally.Message.Player2Added do
  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Score, Tally}

  @spec message(PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def message(:player1, %Tally{
        request: {:add_player, rival, _gender, _pid},
        board_score: %Score{name: name}
      }) do
    [
      :dark_green_background,
      :light_white,
      "#{name}, your opponent, #{rival}, has joined the game."
    ]
  end

  def message(:player2, %Tally{
        request: {:add_player, name, _gender, _pid},
        guesses_score: %Score{name: rival}
      }) do
    [
      :dark_green_background,
      :light_white,
      "#{name}, you've joined the game. Your opponent is #{rival}."
    ]
  end
end
