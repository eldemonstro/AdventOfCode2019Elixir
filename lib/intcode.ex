defmodule IntCode do
  @moduledoc """
  Executes the intcode
  """

  def sum(x, y) do
    {x + y, 4}
  end

  def mul(x, y) do
    {x * y, 4}
  end

  def execute(program, needle) do
    opcode  = program[needle]
    index_x = program[needle + 1]
    index_y = program[needle + 2]
    index_z = program[needle + 3]

    value_x = program[index_x]
    value_y = program[index_y]

    {result, needle_jump} = case opcode do
      1 ->
        sum(value_x, value_y)
      2 ->
        mul(value_x, value_y)
      99 ->
        {:halt, 0}
    end

    case result do
      :halt -> program
      _ -> execute(Map.put(program, index_z, result), needle + needle_jump)
    end
  end
end
