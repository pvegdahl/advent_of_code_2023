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

  def types() do
    # Pre-defining the atoms to enable String.to_existing_atom().  I probably should have just used strings.  Oh well.
    [:seed, :soil, :fertilizer, :water, :light, :temperature, :humidity, :location]
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
  alias AdventOfCode2023.{Helpers, OneMapping, SeedMapping}

  def part_a(lines) do
    {seeds, seed_mapping} = parse_input(lines, &parse_seeds_line_a/1)

    find_min_location(seeds, seed_mapping)
  end

  defp find_min_location(seeds, seed_mapping) do
    seeds
    |> Stream.map(fn seed -> SeedMapping.seed_to_location(seed_mapping, seed) end)
    |> Stream.map(fn {:location, location_number} -> location_number end)
    |> Enum.min()
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
    |> Enum.map(&String.to_existing_atom/1)
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
    {seed_enumerables, seed_mapping} = parse_input(lines, &parse_seeds_line_b/1)

    Task.async_stream(seed_enumerables, &find_min_location(&1, seed_mapping), timeout: 300000)
    |> Enum.map(fn {:ok, num} -> num end)
    |> Enum.min()
  end

  defp parse_seeds_line_b(seeds_line) do
    seeds_line
    |> String.split(":")
    |> Enum.at(1)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, length] -> start..(start+length-1) end)
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
