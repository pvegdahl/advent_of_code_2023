defmodule AdventOfCode2023.Day04 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def parse_line(line) do
    line
    |> String.split(":")
    |> Enum.at(1)
    |> String.split("|")
    |> Enum.map(&numbers_string_to_list/1)
  end

  defp numbers_string_to_list(numbers_string) do
    numbers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_b()
  end
end
