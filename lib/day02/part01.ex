Code.require_file "../intcode.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

value = contents
        |>String.split(~r/[,\n]/)
        |>Enum.reject(& &1 == "")
        |>Enum.map(& String.to_integer(&1))
        |>Enum.with_index(0)
        |>Enum.map(fn {k, v} -> {v, k} end)
        |>Map.new()
        |>Map.put(1, 12)
        |>Map.put(2, 2)
        |>IntCode.execute(0)

IO.puts value[0]
