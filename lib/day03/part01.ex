Code.require_file "../manhatan.ex", __DIR__
Code.require_file "traces.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

closest = contents
          |>String.split(~r/\n/)
          |>Enum.reject(& &1 == "")
          |>Enum.map(& Trace.parse(&1))
          |>Enum.map(& Trace.map(&1))
          |>Trace.find_intersections()
          |>Manhatan.closest_to_origin()

IO.puts abs(closest[:x]) + abs(closest[:y])
