defmodule AdventOfCode2023.Helpers do
  def file_to_lines!(filename) do
    File.stream!(filename, [:utf8])
    |> Stream.map(&String.trim/1)
  end

  def string_to_int_list(integers_string) do
    integers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def reverse_map_of_lists(map_of_lists) do
    [{key, [value]}] = Map.to_list(map_of_lists)
    %{value => [key]}
  end
end
