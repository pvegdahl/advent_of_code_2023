defmodule AdventOfCode2023.Day10 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day10.txt")
    |> part_b()
  end

  def parse_input(lines) do
    lines
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&List.to_tuple/1)
    |> List.to_tuple()
  end

  def find_start(pipe_map) do
    {x_size, y_size} = get_size(pipe_map)

    for x <- 0..(x_size - 1), y <- 0..(y_size - 1), get(pipe_map, {x, y}) == "S" do
      {x, y}
    end
    |> List.first()
  end

  defp get_size(pipe_map) do
    y_size = tuple_size(pipe_map)
    x_size = tuple_size(elem(pipe_map, 0))

    {x_size, y_size}
  end

  defp get(pipe_map, {x, y}) do
    pipe_map
    |> elem(y)
    |> elem(x)
  end

  def find_neighbors(pipe_map, {x, y} = point) do
    case get(pipe_map, point) do
      "|" -> [{x, y - 1}, {x, y + 1}]
      "-" -> [{x - 1, y}, {x + 1, y}]
      "L" -> [{x, y - 1}, {x + 1, y}]
      "J" -> [{x, y - 1}, {x - 1, y}]
      "7" -> [{x - 1, y}, {x, y + 1}]
      "F" -> [{x + 1, y}, {x, y + 1}]
    end
  end
end
