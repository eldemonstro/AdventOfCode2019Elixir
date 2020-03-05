defmodule Trace do
  def parse(trace) do
    trace
    |>String.split(~r/,/)
    |>Enum.reject(& &1 == "")
    |>Enum.map(& String.split_at(&1, 1))
    |>Enum.map(fn {intention, move} ->
      %{intention: intention, move: String.to_integer(move)}
    end)
  end

  def map(trace) do
    res_trace = Enum.reduce(trace, %{x: 0, y: 0, map: []}, fn trace_move, acc ->
                  {x, y, new_map} = calc_trace(acc[:x], acc[:y], trace_move)

                  %{x: x, y: y, map: acc[:map] ++ new_map}
                end)

    res_trace[:map]
  end

  def calc_trace(x, y, trace_move) do
    trace_result = Enum.reduce(1..(trace_move[:move]), %{x: x, y: y, map: []},
      fn _step, positions ->
        {res_x, res_y} = case trace_move[:intention] do
          "R" ->
            {positions[:x] + 1, positions[:y]}
          "L" ->
            {positions[:x] - 1, positions[:y]}
          "U" ->
            {positions[:x], positions[:y] + 1}
          "D" ->
            {positions[:x], positions[:y] - 1}
        end

          %{
            x: res_x,
            y: res_y,
            map: positions[:map] ++ [%{x: res_x, y: res_y}]
          }
      end)

    {trace_result[:x], trace_result[:y], trace_result[:map]}
  end

  def find_intersections(traces) do
    first_trace = List.first(traces)
    second_trace = List.last(traces)

    not_in_second_trace = first_trace -- second_trace

    first_trace -- not_in_second_trace
  end
end
