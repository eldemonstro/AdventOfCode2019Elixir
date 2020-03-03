Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

value = contents
        |>IntCode.parse_program()
        |>Map.put(1, 12)
        |>Map.put(2, 2)
        |>IntCode.execute(0)

IO.puts value[0]
