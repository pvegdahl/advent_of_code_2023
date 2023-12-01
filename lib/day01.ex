defmodule AdventOfCode2023.Day01 do
  def filter_line_to_number(line) do
    line
    |> String.graphemes()
    |> Enum.map(&Integer.parse/1)
    |> Enum.reject(&(&1 == :error))
    |> Enum.map(fn {digit, _} -> digit end)
    |> first_and_last()
    |> Integer.undigits()
  end

  defp first_and_last(list), do: [List.first(list), List.last(list)]

  def add_lines(lines) do
    lines
    |> Enum.map(&filter_line_to_number/1)
    |> Enum.sum()
  end

end