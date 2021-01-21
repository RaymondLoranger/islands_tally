defmodule Islands.Tally.Message do
  alias __MODULE__.{
    AllIslandsPositioned,
    Error,
    HitIslandForested,
    HitNoneForested,
    IslandPositioned,
    IslandsSet,
    MissNoneForested,
    Other,
    Player2Added,
    Stopping
  }

  alias IO.ANSI.Plus, as: ANSI
  alias Islands.{PlayerID, Response, Tally}

  @spec new(Response.t(), PlayerID.t(), Tally.t()) :: ANSI.ansilist()
  def new(response, player_id, tally)

  def new({:ok, :player2_added}, player_id, tally),
    do: Player2Added.message(player_id, tally)

  def new({:ok, :island_positioned}, player_id, tally),
    do: IslandPositioned.message(player_id, tally)

  def new({:ok, :all_islands_positioned}, player_id, tally),
    do: AllIslandsPositioned.message(player_id, tally)

  def new({:ok, :islands_set}, player_id, tally),
    do: IslandsSet.message(player_id, tally)

  def new({:hit, :none, :no_win}, player_id, tally),
    do: HitNoneForested.message(player_id, tally)

  def new({:hit, _type, _status}, player_id, tally),
    do: HitIslandForested.message(player_id, tally)

  def new({:miss, :none, :no_win}, player_id, tally),
    do: MissNoneForested.message(player_id, tally)

  def new({:ok, :stopping}, player_id, tally),
    do: Stopping.message(player_id, tally)

  def new({:error, _reason}, player_id, tally),
    do: Error.message(player_id, tally)

  def new(_other, player_id, tally), do: Other.message(player_id, tally)
end
