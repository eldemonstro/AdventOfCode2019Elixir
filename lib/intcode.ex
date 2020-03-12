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

  def less_than(x, y) do
    {(if x < y, do: 1, else: 0), 4}
  end

  def equals(x, y) do
    {(if x == y, do: 1, else: 0), 4}
  end

  def parse_program(program) do
    program
    |>String.split(~r/[,\n]/)
    |>Enum.reject(& &1 == "")
    |>Enum.map(& String.to_integer(&1))
    |>Enum.with_index(0)
    |>Enum.map(fn {k, v} -> {v, k} end)
    |>Map.new()
  end

  def execute(program, opcode, needle, inputs \\ [])
  def execute(program, opcode, needle, inputs) when rem(opcode, 100) == 99 do
    {program, :halt, needle, inputs}
  end
  def execute(program, opcode, needle, inputs) when rem(opcode, 100) == 6 do
    reversed_opcode = opcode |> Integer.digits() |> Enum.reverse()

    mode_b = Enum.at(reversed_opcode, 3) || 0
    mode_c = Enum.at(reversed_opcode, 2) || 0

    index_x = program[needle + 1]
    index_y = program[needle + 2]

    value_x = program[(if mode_c == 1, do: needle + 1, else: index_x)]
    value_y = program[(if mode_b == 1, do: needle + 2, else: index_y)]

    needle_jump = (if value_x == 0, do: value_y, else: needle + 3)

    execute(program, program[needle_jump], needle_jump, inputs)
  end
  def execute(program, opcode, needle, inputs) when rem(opcode, 100) == 5 do
    reversed_opcode = opcode |> Integer.digits() |> Enum.reverse()

    mode_b = Enum.at(reversed_opcode, 3) || 0
    mode_c = Enum.at(reversed_opcode, 2) || 0

    index_x = program[needle + 1]
    index_y = program[needle + 2]

    value_x = program[(if mode_c == 1, do: needle + 1, else: index_x)]
    value_y = program[(if mode_b == 1, do: needle + 2, else: index_y)]

    needle_jump = (if value_x != 0, do: value_y, else: needle + 3)

    execute(program, program[needle_jump], needle_jump, inputs)
  end
  def execute(program, opcode, needle, inputs) when rem(opcode, 100) == 4 do
    reversed_opcode = opcode |> Integer.digits() |> Enum.reverse()
    mode_c = Enum.at(reversed_opcode, 2) || 0

    index_x = program[needle + 1]
    value_x = program[(if mode_c == 1, do: needle + 1, else: index_x)]

    IO.puts value_x

    execute(program, program[needle + 2], needle + 2, inputs)
  end
  def execute(program, opcode, needle, inputs) when rem(opcode, 100) == 3 do
    [input | new_inputs] = inputs

    index_x = program[needle + 1]

    execute(Map.put(program, index_x, input), program[needle + 2], needle + 2, new_inputs)
  end
  def execute(program, opcode, needle, inputs) do
    reversed_opcode = opcode |> Integer.digits() |> Enum.reverse()

    {mode_a, mode_b, mode_c} = {Enum.at(reversed_opcode, 4, 0), Enum.at(reversed_opcode, 3, 0), Enum.at(reversed_opcode, 2, 0)}

    index_z = program[needle + 3]

    value_x = program[(if mode_c == 1, do: needle + 1, else: program[needle + 1])]
    value_y = program[(if mode_b == 1, do: needle + 2, else: program[needle + 1])]

    {result, needle_jump} = case rem(opcode, 100) do
      1 ->
        sum(value_x, value_y)
      2 ->
        mul(value_x, value_y)
      7 ->
        less_than(value_x, value_y)
      8 ->
        equals(value_x, value_y)
    end

    new_program = Map.put(program, index_z, result)

    execute(new_program, new_program[needle + needle_jump], needle + needle_jump, inputs)
  end
end
