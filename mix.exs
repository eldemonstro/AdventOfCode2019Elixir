defmodule AdventOfCode2019Elixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2019_elixir,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end
end
