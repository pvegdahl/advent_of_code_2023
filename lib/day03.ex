defmodule AdventOfCode2023.Day03 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
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
    |> Enum.map(fn [{col_index, _length}] -> {{col_index, row_index}, "*"} end)
  end

  defp get_symbols(_line) do
    ["*"]
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
