defmodule AdventOfCode2023.Day08 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    {instructions, map} = parse_input(lines)
    instruction_stream = Stream.cycle(instructions)

    count_steps(map, instruction_stream, "AAA", &(&1 == "ZZZ"))
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
    reduce_func = reduce_while_function(map, target_func)

    Enum.reduce_while(instruction_stream, {starting_node, 0}, reduce_func)
    |> elem(1)
  end

  defp reduce_while_function(map, target_func) do
    fn instruction, {node, count} = acc ->
      if target_func.(node) do
        {:halt, acc}
      else
        next_node =
          map
          |> Map.get(node)
          |> elem(instruction)

        {:cont, {next_node, count + 1}}
      end
    end
  end
end
