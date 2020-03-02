defmodule FuelSumHelper do
  @moduledoc """
  Fuel sum helper for helping to sum fuel
  """

  def calc_fuel(value) when value < 0, do: -value
  def calc_fuel(value) do
    fuel_value = Integer.floor_div(value, 3) - 2

    fuel_value + calc_fuel(fuel_value)
  end
end

{ :ok, contents } = File.read("#{Path.dirname(__ENV__.file)}/input.txt")

fuel_sum = contents
           |>String.split(~r/\n/)
           |>Enum.reject(& &1 == "")
           |>Enum.map(& String.to_integer(&1))
           |>Enum.reduce(0,
             fn value, acc -> acc + FuelSumHelper.calc_fuel(value) end)

IO.puts inspect(fuel_sum)
