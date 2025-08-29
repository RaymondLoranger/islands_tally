# ┌───────────────────────────────────────────────────────────────────────┐
# │ Inspired by the book "Functional Web Development" by Lance Halvorsen. │
# │ Also inspired by the course "Elixir for Programmers" by Dave Thomas.  │
# └───────────────────────────────────────────────────────────────────────┘
defmodule Islands.Tally do
  @moduledoc """
  Creates a tally struct for the _Game of Islands_.\s\s
  Also displays the summary of a _Game of Islands_.

  The tally struct contains the fields:

    - `game_state`
    - `player1_state`
    - `player2_state`
    - `request`
    - `response`
    - `board`
    - `board_score`
    - `guesses`
    - `guesses_score`

  representing the properties of a tally in the _Game of Islands_.

  ##### Inspired by the book [Functional Web Development](https://pragprog.com/titles/lhelph/functional-web-development-with-elixir-otp-and-phoenix/) by Lance Halvorsen.

  ##### Also inspired by the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__
  alias __MODULE__.Message
  alias IO.ANSI.Plus, as: ANSI
  alias IO.ANSI.Table

  alias Islands.{
    Board,
    Game,
    Grid,
    Guesses,
    PlayerID,
    Request,
    Response,
    Score,
    State
  }

  @player_ids [:player1, :player2]

  @derive JSON.Encoder
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

  @typedoc "A tally struct for the Game of Islands"
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

  @doc """
  Creates a tally struct for the specified player.
  """
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

  @doc """
  Displays the summary of a game for the specified player.
  """
  @spec summary(t, PlayerID.t(), ANSI.ansilist()) :: :ok
  def summary(tally, player_id, message \\ [])

  def summary(%Tally{response: response} = tally, player_id, []),
    do: Message.new(response, player_id, tally) |> do_summary(tally)

  def summary(tally, _player_id, message), do: do_summary(message, tally)

  ## Private functions

  @spec do_summary(ANSI.ansilist(), t) :: :ok
  defp do_summary(message, tally) do
    :ok = ANSI.puts(message)
    :ok = Score.format(tally.board_score, up: 0, right: 8)
    :ok = Score.format(tally.guesses_score, up: 3, right: 41)
    :ok = Grid.to_maps(tally.board) |> Table.format(spec_name: "left")
    :ok = Grid.to_maps(tally.guesses) |> Table.format(spec_name: "right")

    # Default function => &Islands.Grid.Tile.new/1
    # fun = &Islands.Tally.Tile.new/1
    # :ok = Grid.to_maps(tally.board, fun) |> Table.format(spec_name: "left")
    # :ok = Grid.to_maps(tally.guesses, fun) |> Table.format(spec_name: "right")
  end
end
