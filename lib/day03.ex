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
    matches = Regex.scan(~r/\d+/, line, return: :index)

    all_coordinate_mappings = get_all_coordinate_mappings(matches, row_index)
    all_coordinate_number_mappings = get_all_coordinate_number_mappings(matches, row_index, line)

    {
      all_coordinate_mappings,
      all_coordinate_number_mappings
    }
  end

  defp get_all_coordinate_mappings(matches, row_index) do
    matches
    |> Enum.flat_map(fn [{col_index, length}] -> get_coordinate_mapping(col_index, row_index, length) end)
    |> Enum.into(%{})
  end

  defp get_coordinate_mapping(col_index, row_index, length) do
    start_coordinates = {col_index, row_index}

    col_index..(col_index + length - 1)
    |> Enum.map(&{{&1, row_index}, start_coordinates})
  end

  defp get_all_coordinate_number_mappings(matches, row_index, line) do
    matches
    |> Enum.map(&one_match_to_coordinate_number(&1, row_index, line))
    |> Enum.into(%{})
  end

  defp one_match_to_coordinate_number([{col_index, length}], row_index, line) do
    coordinates = {col_index, row_index}
    number = String.slice(line, col_index, length) |> String.to_integer()

    {coordinates, number}
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
