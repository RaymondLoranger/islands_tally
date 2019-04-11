defmodule Islands.TallyTest do
  use ExUnit.Case, async: true

  alias Islands.{Board, Game, Guesses, Score, Tally}

  doctest Tally

  setup_all do
    this = self()

    tally =
      "Tetra"
      |> Game.new("Jay", :m, this)
      |> Game.update_player(:player2, "Kim", :f, this)
      |> Tally.new(:player1)

    poison =
      ~s<{\"response\":[],\"request\":[],\"player2_state\":\"islands_not_set\",\"player1_state\":\"islands_not_set\",\"guesses_score\":{\"name\":\"Kim\",\"misses\":0,\"hits\":0,\"gender\":\"f\",\"forested_types\":[]},\"guesses\":{\"misses\":[],\"hits\":[]},\"game_state\":\"initialized\",\"board_score\":{\"name\":\"Jay\",\"misses\":0,\"hits\":0,\"gender\":\"m\",\"forested_types\":[]},\"board\":{\"misses\":[],\"islands\":{}}}>

    jason =
      ~s<{\"board\":{\"islands\":{},\"misses\":[]},\"board_score\":{\"forested_types\":[],\"gender\":\"m\",\"hits\":0,\"misses\":0,\"name\":\"Jay\"},\"game_state\":\"initialized\",\"guesses\":{\"hits\":[],\"misses\":[]},\"guesses_score\":{\"forested_types\":[],\"gender\":\"f\",\"hits\":0,\"misses\":0,\"name\":\"Kim\"},\"player1_state\":\"islands_not_set\",\"player2_state\":\"islands_not_set\",\"request\":[],\"response\":[]}>

    decoded = %{
      "board" => %{"islands" => %{}, "misses" => []},
      "game_state" => "initialized",
      "guesses" => %{"hits" => [], "misses" => []},
      "player1_state" => "islands_not_set",
      "player2_state" => "islands_not_set",
      "request" => [],
      "response" => [],
      "board_score" => %{
        "forested_types" => [],
        "hits" => 0,
        "misses" => 0,
        "gender" => "m",
        "name" => "Jay"
      },
      "guesses_score" => %{
        "forested_types" => [],
        "hits" => 0,
        "misses" => 0,
        "gender" => "f",
        "name" => "Kim"
      }
    }

    {:ok, json: %{poison: poison, jason: jason, decoded: decoded}, tally: tally}
  end

  describe "A tally struct" do
    test "can be encoded by Poison", %{tally: tally, json: json} do
      assert Poison.encode!(tally) == json.poison
      assert Poison.decode!(json.poison) == json.decoded
    end

    test "can be encoded by Jason", %{tally: tally, json: json} do
      assert Jason.encode!(tally) == json.jason
      assert Jason.decode!(json.jason) == json.decoded
    end
  end

  describe "Tally.new/2" do
    test "returns %Tally{} given valid args", %{tally: tally} do
      %Tally{
        game_state: :initialized,
        player1_state: :islands_not_set,
        player2_state: :islands_not_set,
        request: {},
        response: {},
        board: board,
        board_score: board_score,
        guesses: guesses,
        guesses_score: guesses_score
      } = tally

      assert board == %Board{islands: %{}, misses: MapSet.new()}
      assert guesses == %Guesses{hits: MapSet.new(), misses: MapSet.new()}

      assert board_score == %Score{
               name: "Jay",
               gender: :m,
               hits: 0,
               misses: 0,
               forested_types: []
             }

      assert guesses_score == %Score{
               name: "Kim",
               gender: :f,
               hits: 0,
               misses: 0,
               forested_types: []
             }
    end

    test "returns {:error, ...} given invalid args" do
      game = Game.new("Jade", "John", :m, self())
      assert Tally.new(game, :player3) == {:error, :invalid_tally_args}
    end
  end
end
