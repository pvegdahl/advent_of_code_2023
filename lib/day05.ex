defmodule AdventOfCode2023.OneMapping do
  defstruct [:destination]

  def new(_source, destination, _), do: %__MODULE__{destination: destination}

  def next(%__MODULE__{destination: destination}, _source, source_num), do: {destination, source_num}
end

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
