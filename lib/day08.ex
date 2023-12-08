defmodule AdventOfCode2023.Day08 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    {instructions, map} = parse_input(lines)
    instruction_stream = Stream.cycle(instructions)

    count_steps(map, instruction_stream)
  end

  def part_b(_lines) do
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

    {String.graphemes(instruction_line), parse_map(map_lines)}
  end

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

  defp count_steps(map, instruction_stream, current \\ "AAA", target \\ "ZZZ", step_count \\ 0)
  defp count_steps(_map, _instruction_stream, target, target, step_count), do: step_count

  defp count_steps(map, instruction_stream, current, target, step_count) do
    next_node = get_next(map, instruction_stream, current)
    new_stream = Stream.drop(instruction_stream, 1)

    count_steps(map, new_stream, next_node, target, step_count + 1)
  end

  defp get_next(map, instruction_stream, current) do
    next_instruction = get_instruction_index(instruction_stream)

    map
    |> Map.get(current)
    |> elem(next_instruction)
  end

  defp get_instruction_index(instruction_stream) do
    case Enum.at(instruction_stream, 0) do
      "L" -> 0
      "R" -> 1
    end
  end
end
