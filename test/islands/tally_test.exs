defmodule Islands.TallyTest do
  use ExUnit.Case, async: true

  alias Islands.{Board, Game, Guesses, Player, Score, Tally}

  doctest Tally

  setup_all do
    this = self()
    game = Game.new("Tetra", "Jay", :m, this)
    tally = Tally.new(game, :player1)

    poison =
      ~s<{\"response\":[],\"request\":[],\"player2_state\":\"islands_not_set\",\"player2\":{\"name\":\"?\",\"guesses\":{\"misses\":[],\"hits\":[]},\"gender\":\"f\",\"board\":{\"misses\":[],\"islands\":{}}},\"player1_state\":\"islands_not_set\",\"player1\":{\"name\":\"Jay\",\"guesses\":{\"misses\":[],\"hits\":[]},\"gender\":\"m\",\"board\":{\"misses\":[],\"islands\":{}}},\"guesses_score\":{\"misses\":0,\"hits\":0,\"forested_types\":[]},\"guesses\":{\"misses\":[],\"hits\":[]},\"game_state\":\"initialized\",\"board_score\":{\"misses\":0,\"hits\":0,\"forested_types\":[]},\"board\":{\"misses\":[],\"islands\":{}}}>

    jason =
      ~s<{\"board\":{\"islands\":{},\"misses\":[]},\"board_score\":{\"forested_types\":[],\"hits\":0,\"misses\":0},\"game_state\":\"initialized\",\"guesses\":{\"hits\":[],\"misses\":[]},\"guesses_score\":{\"forested_types\":[],\"hits\":0,\"misses\":0},\"player1\":{\"name\":\"Jay\",\"gender\":\"m\",\"board\":{\"islands\":{},\"misses\":[]},\"guesses\":{\"hits\":[],\"misses\":[]}},\"player1_state\":\"islands_not_set\",\"player2\":{\"name\":\"?\",\"gender\":\"f\",\"board\":{\"islands\":{},\"misses\":[]},\"guesses\":{\"hits\":[],\"misses\":[]}},\"player2_state\":\"islands_not_set\",\"request\":[],\"response\":[]}>

    decoded = %{
      "board" => %{"islands" => %{}, "misses" => []},
      "board_score" => %{"forested_types" => [], "hits" => 0, "misses" => 0},
      "game_state" => "initialized",
      "guesses" => %{"hits" => [], "misses" => []},
      "guesses_score" => %{"forested_types" => [], "hits" => 0, "misses" => 0},
      "player1" => %{
        "board" => %{"islands" => %{}, "misses" => []},
        "gender" => "m",
        "guesses" => %{"hits" => [], "misses" => []},
        "name" => "Jay"
      },
      "player1_state" => "islands_not_set",
      "player2" => %{
        "board" => %{"islands" => %{}, "misses" => []},
        "gender" => "f",
        "guesses" => %{"hits" => [], "misses" => []},
        "name" => "?"
      },
      "player2_state" => "islands_not_set",
      "request" => [],
      "response" => []
    }

    {:ok,
     json: %{poison: poison, jason: jason, decoded: decoded},
     pid: this,
     tally: tally}
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
    test "returns %Tally{} given valid args", %{tally: tally, pid: that} do
      %Tally{
        game_state: :initialized,
        player1_state: :islands_not_set,
        player1: player1,
        player2_state: :islands_not_set,
        player2: player2,
        request: {},
        response: {},
        board: board,
        board_score: board_score,
        guesses: guesses,
        guesses_score: guesses_score
      } = tally

      assert board == %Board{islands: %{}, misses: MapSet.new()}
      assert guesses == %Guesses{hits: MapSet.new(), misses: MapSet.new()}
      assert board_score == %Score{hits: 0, misses: 0, forested_types: []}
      assert guesses_score == %Score{hits: 0, misses: 0, forested_types: []}
      assert player1 == %Player{name: "Jay", gender: :m, pid: that}
      assert player2 == %Player{name: "?", gender: :f, pid: nil}
    end

    test "returns {:error, ...} given invalid args" do
      game = Game.new("Jade", "John", :m, self())
      assert Tally.new(game, :player3) == {:error, :invalid_tally_args}
    end
  end
end
