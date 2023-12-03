defmodule AdventOfCode2023.Day03 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def get_symbol_locations(line, row_index) do
    "*"
    |> Regex.escape()
    |> Regex.compile!()
    |> Regex.run(line, return: :index)
    |> Enum.map(fn {col_index, _length} -> {{col_index, row_index}, "*"} end)
    |> Enum.into(%{})
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
