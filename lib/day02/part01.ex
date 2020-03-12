Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

intcode = contents
          |>IntCode.parse_program()
          |>Map.put(1, 12)
          |>Map.put(2, 2)

{:ok, first_op} = Map.fetch(intcode, 0)

{value, _, _, _} = IntCode.execute(intcode, first_op, 0)

IO.puts value[0]
