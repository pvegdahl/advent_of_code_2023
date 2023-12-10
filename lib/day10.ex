defmodule AdventOfCode2023.Day10 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_b()
  end

  def parse_input(lines) do
    lines
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
  end
end
