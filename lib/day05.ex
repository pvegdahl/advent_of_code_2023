defmodule AdventOfCode2023.OneMapping do
  defstruct [:source, :destination, :mapping]

  def new(source, destination, mappings) do
    %__MODULE__{source: source, destination: destination, mapping: build_mappings(mappings)}
  end

  defp build_mappings([]), do: %{}
  defp build_mappings([{dest_start, source_start, _}]) do
    %{source_start => dest_start}
  end

  def next(%__MODULE__{source: source, destination: destination, mapping: mapping}, source, source_num) do
    result = Map.get(mapping, source_num, source_num)
    {destination, result}
    end

  def next(_one_mapping, _source, _source_num), do: :error
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
