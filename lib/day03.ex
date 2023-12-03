defmodule AdventOfCode2023.Day03 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    {coordinate_mappings, coordinate_number_mappings} = get_all_number_locations(lines)

    get_all_symbol_locations(lines)
    |> Map.keys()
    |> get_neighbors()
    |> Enum.map(&Map.get(coordinate_mappings, &1))
    |> Enum.reject(&(&1 == nil))
    |> Enum.uniq()
    |> Enum.map(&Map.get(coordinate_number_mappings, &1))
    |> Enum.sum()
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

  def get_all_number_locations(lines) do
    lines
    |> Enum.with_index()
    |> Enum.map(fn {line, row_index} -> get_number_locations(line, row_index) end)
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn list_of_maps -> Enum.reduce(list_of_maps, &Map.merge/2) end)
    |> List.to_tuple()
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

  def get_neighbors(points) do
    points
    |> Enum.flat_map(&get_neighbors_of_one_point/1)
    |> MapSet.new()
    |> MapSet.difference(MapSet.new(points))
  end

  defp get_neighbors_of_one_point({x, y}) do
    for xx <- (x - 1)..(x + 1), yy <- (y - 1)..(y + 1) do
      {xx, yy}
    end
  end

  def part_b(_lines) do
  end

  def find_gears(symbol_map) do
    symbol_map
    |> Map.filter(&is_gear?/1)
    |> Map.keys()
    |> MapSet.new()
  end

  defp is_gear?({_key, "*"}), do: true
  defp is_gear?(_), do: false

  def neighbor_pairs(lines) do
    lines
    |> neighbors_of_gears()
    |> Enum.filter(&(Enum.count(&1) == 2))
  end

  defp neighbors_of_gears(lines) do
    {coordinate_mappings, coordinate_number_mappings} = get_all_number_locations(lines)
    lines
    |> get_all_symbol_locations()
    |> find_gears()
    |> Enum.map(&neighbor_numbers_of_point(&1, coordinate_mappings, coordinate_number_mappings))
  end

  defp neighbor_numbers_of_point(point, coordinate_mappings, coordinate_number_mappings)  do
    point
    |> get_neighbors_of_one_point()
    |> Enum.map(&Map.get(coordinate_mappings, &1))
    |> Enum.reject(&(&1 == nil))
    |> Enum.uniq()
    |> Enum.map(&Map.get(coordinate_number_mappings, &1))
    |> Enum.sort()
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
