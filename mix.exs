defmodule Islands.Tally.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_tally,
      version: "0.1.14",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Islands Tally",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_tally"
  end

  defp description do
    """
    Creates a tally struct for the Game of Islands.
    Also displays the summary of a Game of Islands.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Islands.Tally.App, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:io_ansi_plus, "~> 0.1"},
      {:io_ansi_table, "~> 1.0"},
      {:islands_board, "~> 0.1"},
      {:islands_coord, "~> 0.1"},
      {:islands_game, "~> 0.1"},
      {:islands_grid, "~> 0.1"},
      {:islands_guesses, "~> 0.1"},
      {:islands_island, "~> 0.1"},
      {:islands_player, "~> 0.1"},
      {:islands_player_id, "~> 0.1"},
      {:islands_request, "~> 0.1"},
      {:islands_response, "~> 0.1"},
      {:islands_score, "~> 0.1"},
      {:islands_state, "~> 0.1"},
      {:jason, "~> 1.0"},
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:persist_config, "~> 0.4", runtime: false},
      {:poison, "~> 4.0"}
    ]
  end
end
