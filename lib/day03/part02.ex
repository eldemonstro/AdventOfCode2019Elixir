Code.require_file "../manhatan.ex", __DIR__
Code.require_file "traces.ex", __DIR__

{ :ok, contents } = File.read("#{__DIR__}/input.txt")

traces = contents
         |>String.split(~r/\n/)
         |>Enum.reject(& &1 == "")
         |>Enum.map(& Trace.parse(&1))
         |>Enum.map(& Trace.map(&1))

intersections = Trace.find_intersections(traces)

[first_trace | [second_trace | _]] = traces

IO.puts Enum.reduce(intersections, 999_999_999, fn coord, acc ->
  first_trace_distance = Trace.trace_distance(first_trace, coord)
  second_trace_distance = Trace.trace_distance(second_trace, coord)

  if first_trace_distance + second_trace_distance < acc do
    first_trace_distance + second_trace_distance
  else
    acc
  end
end)
