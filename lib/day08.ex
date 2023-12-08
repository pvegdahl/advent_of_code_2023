defmodule AdventOfCode2023.Day08 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_b()
  end

  def parse_input(lines) do
    [instruction_line, "" | map_lines] = lines

    {String.graphemes(instruction_line), parse_map(map_lines)}
  end

  defp parse_map(lines) do
    lines
    |> Enum.map(&parse_map_line/1)
    |> Enum.into(Map.new())
  end

  defp parse_map_line(line) do
    parts = String.split(line, " ")
    node = Enum.at(parts, 0)
    left = Enum.at(parts, 2) |> String.slice(1, 3)
    right = Enum.at(parts, 3) |> String.slice(0, 3)
    {node, {left, right}}
  end
end
