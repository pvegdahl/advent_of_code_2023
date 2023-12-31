defmodule AdventOfCode2023.RangeSet do
  defstruct ranges: []

  def new(ranges), do: %__MODULE__{ranges: ranges}

  def split_overlapping(%__MODULE__{ranges: ranges}, comparison) do
    range_pairs = Enum.map(ranges, &split_one_overlapping(&1, comparison))

    overlaps = Enum.flat_map(range_pairs, fn {overlaps, _non_overlaps} -> overlaps end)
    non_overlaps = Enum.flat_map(range_pairs, fn {_overlaps, non_overlaps} -> non_overlaps end)

    {new(overlaps), new(non_overlaps)}
  end

  defp split_one_overlapping(range_start..range_end = range, comparison_start..comparison_end = comparison_range) do
    start_location = relative_location(range, comparison_start)
    end_location = relative_location(range, comparison_end)

    cond do
      no_overlap?(start_location, end_location) ->
        {[], [range]}

      full_overlap?(start_location, end_location) ->
        {[range], []}

      start_at_start?(start_location) ->
        {[range_start..comparison_end], [(comparison_end + 1)..range_end]}

      end_at_end?(end_location) ->
        {[comparison_start..range_end], [range_start..(comparison_start - 1)]}

      middle_split?(start_location, end_location) ->
        {[comparison_range], [range_start..(comparison_start - 1), (comparison_end + 1)..range_end]}
    end
  end

  defp no_overlap?(start_location, end_location), do: start_location == :after or end_location == :before

  defp full_overlap?(start_location, end_location), do: start_at_start?(start_location) && end_at_end?(end_location)

  defp start_at_start?(start_location), do: start_location == :before or start_location == :start

  defp end_at_end?(end_location), do: end_location == :after or end_location == :end

  defp middle_split?(start_location, end_location), do: start_location == :middle and end_location == :middle

  defp relative_location(range_start..range_end, x) do
    cond do
      x < range_start -> :before
      x > range_end -> :after
      x == range_start -> :start
      x == range_end -> :end
      true -> :middle
    end
  end

  def shift(%__MODULE__{ranges: ranges}, amount), do: Enum.map(ranges, &Range.shift(&1, amount)) |> new()

  def shift_overlapping(range_set, comparison, amount) do
    {overlapping, non_overlapping} = split_overlapping(range_set, comparison)
    shifted = shift(overlapping, amount)
    {shifted, non_overlapping}
  end

  def min(%__MODULE__{ranges: ranges}) do
    ranges
    |> Enum.map(&Enum.min/1)
    |> Enum.min()
  end

  def concat(%__MODULE__{ranges: ranges1}, %__MODULE__{ranges: ranges2}), do: Enum.concat(ranges1, ranges2) |> new()
end

defmodule AdventOfCode2023.OneMapping do
  alias AdventOfCode2023.RangeSet

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

  def next(
        %__MODULE__{source: source, destination: destination, mapping: mappings},
        source,
        %RangeSet{} = source_range_set
      ) do
    {updated, no_updates} = Enum.reduce(mappings, {RangeSet.new([]), source_range_set}, &shift_overlapping/2)
    {destination, RangeSet.concat(updated, no_updates)}
  end

  def next(%__MODULE__{source: source, destination: destination, mapping: mappings}, source, source_num) do
    destination_num = Enum.reduce_while(mappings, source_num, &try_range/2)
    {destination, destination_num}
  end

  def next(_one_mapping, _source, _source_num), do: :error

  def next_range_set(
        %__MODULE__{source: source, destination: destination, mapping: mappings},
        source,
        %RangeSet{} = source_range_set
      ) do
    {updated, no_updates} = Enum.reduce(mappings, {RangeSet.new([]), source_range_set}, &shift_overlapping/2)
    {destination, RangeSet.concat(updated, no_updates)}
  end

  defp try_range({source_range, diff}, source_num) do
    if source_num in source_range do
      {:halt, source_num + diff}
    else
      {:cont, source_num}
    end
  end

  def shift_overlapping({source_range, diff}, {overlapping, non_overlapping}) do
    {new_overlapping, still_non_overlapping} = RangeSet.shift_overlapping(non_overlapping, source_range, diff)
    {RangeSet.concat(overlapping, new_overlapping), still_non_overlapping}
  end
end

defmodule AdventOfCode2023.SeedMapping do
  alias AdventOfCode2023.OneMapping

  def new(mappings) do
    mappings
    |> Enum.map(fn %OneMapping{source: source} = mapping -> {source, mapping} end)
    |> Enum.into(%{})
  end

  def seed_to_location(mappings, seed_num) do
    seed_to_location_helper(mappings, :seed, seed_num)
  end

  defp seed_to_location_helper(%{} = mappings, source, source_num) do
    case Map.get(mappings, source) do
      nil ->
        {source, source_num}

      one_mapping ->
        {destination, destination_num} = OneMapping.next(one_mapping, source, source_num)
        seed_to_location_helper(mappings, destination, destination_num)
    end
  end
end

defmodule AdventOfCode2023.Day05 do
  alias AdventOfCode2023.{Helpers, OneMapping, RangeSet, SeedMapping}

  def part_a(lines) do
    {seeds, seed_mapping} = parse_input(lines, &parse_seeds_line_a/1)

    find_min_location_a(seeds, seed_mapping)
  end

  defp find_min_location_a(seeds, seed_mapping) do
    seeds
    |> Stream.map(fn seed -> SeedMapping.seed_to_location(seed_mapping, seed) end)
    |> Stream.map(fn {:location, location_number} -> location_number end)
    |> Enum.min()
  end

  defp find_min_location_b(seeds_range_set, seed_mapping) do
    {:location, result_range_set} = SeedMapping.seed_to_location(seed_mapping, seeds_range_set)
    RangeSet.min(result_range_set)
  end

  defp parse_input(lines, parse_seed_function) do
    {seeds_line, mapping_groups} = split_input(lines)

    seeds = parse_seed_function.(seeds_line)
    seed_mappings = Enum.map(mapping_groups, &parse_mapping_groups/1) |> AdventOfCode2023.SeedMapping.new()

    {seeds, seed_mappings}
  end

  defp split_input(lines) do
    {[[seeds_line]], mapping_lines} =
      lines
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.split(1)

    {seeds_line, Enum.drop_every(mapping_lines, 2)}
  end

  defp parse_seeds_line_a(seeds_line) do
    seeds_line
    |> String.split(":")
    |> Enum.at(1)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_mapping_groups(mapping_group) do
    {[header], mapping_numbers} = Enum.split(mapping_group, 1)
    {source, destination} = parse_header(header)
    mapping_numbers = parse_mapping_numbers(mapping_numbers)

    OneMapping.new(source, destination, mapping_numbers)
  end

  defp parse_header(header) do
    header
    |> String.split(" ")
    |> Enum.at(0)
    |> String.split("-to-")
    |> Enum.map(&String.to_atom/1)
    |> List.to_tuple()
  end

  defp parse_mapping_numbers(lines), do: Enum.map(lines, &parse_one_line_of_mapping_numbers/1)

  defp parse_one_line_of_mapping_numbers(line) do
    line
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def part_b(lines) do
    {seed_range_set, seed_mapping} = parse_input(lines, &parse_seeds_line_b/1)

    find_min_location_b(seed_range_set, seed_mapping)
  end

  defp parse_seeds_line_b(seeds_line) do
    seeds_line
    |> String.split(":")
    |> Enum.at(1)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, length] -> start..(start + length - 1) end)
    |> RangeSet.new()
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
