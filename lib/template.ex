defmodule AdventOfCode2023.DayXX do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/dayXX.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/dayXX.txt")
    |> part_b()
  end
end