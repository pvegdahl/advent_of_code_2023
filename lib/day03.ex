defmodule AdventOfCode2023.Day03 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def get_all_symbol_locations(lines) do
    lines
    |> Enum.with_index()
    |> Enum.map(fn {line, row_index} -> get_symbol_locations(line, row_index) end)
    |> Enum.reduce(&Map.merge/2)
  end

  def get_symbol_locations(line, row_index) do
    get_symbols(line)
    |> Enum.flat_map(&get_specific_symbol_locations(line, &1, row_index))
    |> Enum.into(%{})
  end

  defp get_specific_symbol_locations(line, symbol, row_index) do
    symbol
    |> Regex.escape()
    |> Regex.compile!()
    |> Regex.scan(line, return: :index)
    |> Enum.map(fn [{col_index, _length}] -> {{col_index, row_index}, symbol} end)
  end

  defp get_symbols(line) do
    line
    |> String.graphemes()
    |> Enum.reject(&(&1 == "."))
    |> Enum.filter(&(Integer.parse(&1) == :error))
    |> Enum.uniq()
  end

  def get_number_locations(line, row_index) do
    [{col_index, length}] = Regex.run(~r/\d+/, line, return: :index)

    number = String.slice(line, col_index, length) |> String.to_integer()
    coordinates = {col_index, row_index}

    coordinate_mapping =
      get_coordinate_mapping(col_index, row_index, length)
      |> Enum.into(%{})

    {
      coordinate_mapping,
      %{coordinates => number}
    }
  end

  defp get_coordinate_mapping(col_index, row_index, length) do
    start_coordinates = {col_index, row_index}

    col_index..(col_index + length - 1)
    |> Enum.map(&{{&1, row_index}, start_coordinates})
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day03.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day03.txt")
    |> part_b()
  end
end
