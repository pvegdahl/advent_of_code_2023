defmodule AdventOfCode2023.OneMapping do
  defstruct [:source, :destination, :mapping]

  def new(source, destination, mappings) do
    %__MODULE__{source: source, destination: destination, mapping: build_mappings(mappings)}
  end

  defp build_mappings([]), do: nil

  defp build_mappings(mappings) do
    Enum.map(mappings, &build_one_mapping/1)
  end

  defp build_one_mapping({dest_start, source_start, length}) do
    diff = dest_start - source_start
    source_range = source_start..(source_start + length - 1)
    {source_range, diff}
  end

  def next(%__MODULE__{source: source, destination: destination, mapping: nil}, source, source_num) do
    {destination, source_num}
  end

  def next(%__MODULE__{source: source, destination: destination, mapping: mappings}, source, source_num) do
    destination_num = Enum.reduce_while(mappings, source_num, &try_range/2)
    {destination, destination_num}
  end

  def next(_one_mapping, _source, _source_num), do: :error

  defp try_range({source_range, diff}, source_num) do
    if source_num in source_range do
      {:halt, source_num + diff}
    else
      {:cont, source_num}
    end
  end
end

defmodule AdventOfCode2023.SeedMapping do
  def new([]), do: nil

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
