defmodule AdventOfCode2023.Day01 do
  def filter_line_to_number(line) do
    line
    |> String.graphemes()
    |> first_and_last()
    |> Enum.join()
    |> String.to_integer()
  end

  defp first_and_last(list), do: [List.first(list), List.last(list)]
end