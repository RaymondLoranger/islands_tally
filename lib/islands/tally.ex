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
    Player,
    PlayerID,
    Request,
    Response,
    Score,
    State
  }

  @derive [Poison.Encoder]
  @derive Jason.Encoder
  @enforce_keys [
    :game_state,
    :player1_state,
    :player1,
    :player2_state,
    :player2,
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
    :player1,
    :player2_state,
    :player2,
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
          player1: Player.t(),
          player2_state: State.player_state(),
          player2: Player.t(),
          request: Request.t(),
          response: Response.t(),
          board: Board.t(),
          board_score: Score.t(),
          guesses: Guesses.t(),
          guesses_score: Score.t()
        }

  @player_ids [:player1, :player2]

  @spec new(Game.t(), PlayerID.t()) :: t | {:error, atom}
  def new(%Game{} = game, player_id) when player_id in @player_ids do
    player = game[player_id]
    opponent = game[Game.opponent_id(player_id)]

    %Tally{
      game_state: game.state.game_state,
      player1_state: game.state.player1_state,
      player1: game.player1,
      player2_state: game.state.player2_state,
      player2: game.player2,
      request: game.request,
      response: game.response,
      board: player.board,
      board_score: Score.new(player.board),
      guesses: player.guesses,
      guesses_score: Score.new(opponent.board)
    }
  end

  def new(_game, _player_id), do: {:error, :invalid_tally_args}

  @spec player(t, PlayerID.t()) :: Player.t()
  def player(%Tally{} = tally, :player1), do: tally.player1
  def player(%Tally{} = tally, :player2), do: tally.player2

  @spec opponent(t, PlayerID.t()) :: Player.t()
  def opponent(%Tally{} = tally, :player1), do: tally.player2
  def opponent(%Tally{} = tally, :player2), do: tally.player1
end
