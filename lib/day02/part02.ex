Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

required_output = 19_690_720

Enum.find(0..99, fn noun ->
  Enum.find(0..99, fn verb ->
    {:ok, value} = contents
                   |>IntCode.parse_program()
                   |>Map.put(1, noun)
                   |>Map.put(2, verb)
                   |>IntCode.execute(0)
                   |>Map.fetch(0)

    if value == required_output do
      IO.puts(100 * noun + verb)
    end
  end)
end)
