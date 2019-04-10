# ┌───────────────────────────────────────────────────────────────────────┐
# │ Inspired by the book "Functional Web Development" by Lance Halvorsen. │
# └───────────────────────────────────────────────────────────────────────┘
defmodule Islands.Tally do
  use PersistConfig

  @book_ref Application.get_env(@app, :book_ref)

  @moduledoc """
  Creates a `tally` struct for the _Game of Islands_.
  \n##### #{@book_ref}
  """

  alias __MODULE__

  alias Islands.{
    Board,
    Game,
    Guesses,
    PlayerID,
    Request,
    Response,
    Score,
    State
  }

  @player_ids [:player1, :player2]

  @derive [Poison.Encoder]
  @derive Jason.Encoder
  @enforce_keys [
    :game_state,
    :player1_state,
    :player2_state,
    :request,
    :response,
    :board,
    :board_score,
    :guesses,
    :guesses_score
  ]
  defstruct [
    :game_state,
    :player1_state,
    :player2_state,
    :request,
    :response,
    :board,
    :board_score,
    :guesses,
    :guesses_score
  ]

  @type t :: %Tally{
          game_state: State.game_state(),
          player1_state: State.player_state(),
          player2_state: State.player_state(),
          request: Request.t(),
          response: Response.t(),
          board: Board.t(),
          board_score: Score.t(),
          guesses: Guesses.t(),
          guesses_score: Score.t()
        }

  @spec new(Game.t(), PlayerID.t()) :: t | {:error, atom}
  def new(%Game{} = game, player_id) when player_id in @player_ids do
    %Tally{
      game_state: game.state.game_state,
      player1_state: game.state.player1_state,
      player2_state: game.state.player2_state,
      request: game.request,
      response: game.response,
      board: game[player_id].board,
      board_score: Score.board_score(game, player_id),
      guesses: game[player_id].guesses,
      guesses_score: Score.guesses_score(game, player_id)
    }
  end

  def new(_game, _player_id), do: {:error, :invalid_tally_args}
end
