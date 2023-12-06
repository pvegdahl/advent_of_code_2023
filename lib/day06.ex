defmodule AdventOfCode2023.SearchRange do
  def range_of_true(first..last = range, is_true?) do
    new_first = Enum.find(range, is_true?)
    new_last = Enum.find(last..first, is_true?)

    new_first..new_last
  end
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
