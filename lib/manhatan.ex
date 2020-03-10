defmodule Manhatan do
  @moduledoc"""
  Used to calculate distances given coordinates using manhatan distances
  """
  def closest_to_origin(coords) do
    Enum.reduce(coords, %{x: 999_999_999, y: 999_999_999}, fn coord, closest ->
      if abs(closest[:x]) + abs(closest[:y]) < abs(coord[:x]) + abs(coord[:y]) do
        closest
      else
        coord
      end
    end)
  end
end
