Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

required_output = 19_690_720

Enum.find(0..99, fn noun ->
  Enum.find(0..99, fn verb ->
    intcode = contents
              |>IntCode.parse_program()
              |>Map.put(1, noun)
              |>Map.put(2, verb)

    {:ok, first_op} = Map.fetch(intcode, 0)

    { value, _ , _, _} = IntCode.execute(intcode, first_op, 0)

    if value[0] == required_output do
      IO.puts(100 * noun + verb)
    end
  end)
end)
