defmodule AdventOfCode2023.SeedMapping do
  def new(), do: nil

  def seed_to_location(_seed_mapping, seed), do: seed
end

defmodule AdventOfCode2023.Day05 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day05.txt")
    |> part_b()
  end
end
