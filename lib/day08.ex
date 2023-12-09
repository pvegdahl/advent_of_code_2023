defmodule AdventOfCode2023.Day08 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    {instructions, map} = parse_input(lines)
    instruction_stream = Stream.cycle(instructions)

    count_steps(map, instruction_stream, "AAA", &(&1 == "ZZZ"))
  end

  def part_b(lines) do
    {instructions, map} = parse_input(lines)
    instruction_stream = Stream.cycle(instructions)
    starting_nodes = find_starting_nodes(map)

    stream_specs(map, instruction_stream, starting_nodes)
    |> Enum.reduce(&merge_stream_specs/2)
    |> elem(0)
  end

  def a() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day08.txt")
    |> part_b()
  end

  def parse_input(lines) do
    [instruction_line, "" | map_lines] = Enum.to_list(lines)

    {parse_instructions(instruction_line), parse_map(map_lines)}
  end

  defp parse_instructions(instructions_line) do
    instructions_line
    |> String.graphemes()
    |> Enum.map(&left_or_right_to_zero_or_one/1)
  end

  defp left_or_right_to_zero_or_one("L"), do: 0
  defp left_or_right_to_zero_or_one("R"), do: 1

  defp parse_map(lines) do
    lines
    |> Enum.map(&parse_map_line/1)
    |> Enum.into(Map.new())
  end

  defp parse_map_line(line) do
    parts = String.split(line, " ")
    node = Enum.at(parts, 0)
    left = Enum.at(parts, 2) |> String.slice(1, 3)
    right = Enum.at(parts, 3) |> String.slice(0, 3)
    {node, {left, right}}
  end

  defp count_steps(map, instruction_stream, starting_node, target_func) do
    build_path_stream(map, instruction_stream, starting_node)
    |> Enum.find(fn {node, _index} -> target_func.(node) end)
    |> elem(1)
  end

  defp build_path_stream(map, instruction_stream, starting_node) do
    Stream.scan(instruction_stream, starting_node, fn instruction, node -> next(map, node, instruction) end)
    |> Stream.with_index(1)
  end

  defp next(map, node, instruction) do
    map
    |> Map.get(node)
    |> elem(instruction)
  end

  def find_starting_nodes(map) do
    map
    |> Map.keys()
    |> Enum.filter(&String.ends_with?(&1, "A"))
    |> Enum.sort()
  end

  defp stream_terminal_node_indices(map, instruction_stream, starting_node) do
    build_path_stream(map, instruction_stream, starting_node)
    |> Stream.filter(fn {node, _index} -> String.ends_with?(node, "Z") end)
    |> Stream.map(&elem(&1, 1))
  end

  defp stream_specs(map, instruction_stream, starting_nodes) do
    starting_nodes
    |> Enum.map(fn node -> stream_terminal_node_indices(map, instruction_stream, node) end)
    |> Enum.map(&stream_spec/1)
  end

  defp stream_spec(slow_stream) do
    [a, b, c] = Enum.take(slow_stream, 3)

    ba = b - a
    cb = c - b

    cond do
      ba == cb -> {a, ba}
    end
  end

  def merge_stream_specs({interval_a, interval_a}, {interval_b, interval_b}) do
    lcm = least_common_multiple(interval_a, interval_b)
    {lcm, lcm}
  end

  def merge_stream_specs({_, interval_a} = stream_spec_a, {_, interval_b} = stream_spec_b) do
    interval = least_common_multiple(interval_a, interval_b)
    offset = least_common_offset(stream_spec_a, stream_spec_b)
    {offset, interval}
  end

  defp least_common_offset({offset, _interval_a}, {offset, _interval_b}), do: offset

  defp least_common_offset({offset_a, interval_a}, {offset_b, _} = stream_spec_b) when offset_a < offset_b do
    least_common_offset({offset_a + interval_a, interval_a}, stream_spec_b)
  end

  defp least_common_offset({offset_a, _} = stream_spec_a, {offset_b, interval_b}) when offset_a > offset_b do
    least_common_offset(stream_spec_a, {offset_b + interval_b, interval_b})
  end

  defp least_common_multiple(a, b) do
    gcd = Integer.gcd(a, b)
    div(a * b, gcd)
  end
end
