defmodule AdventOfCode2023.SearchRange do
  def range_of_true(range, _), do: range
end

defmodule AdventOfCode2023.Day06 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_b()
  end
end
