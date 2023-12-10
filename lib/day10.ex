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

    for x <- 0..(x_size-1), y <- 0..(y_size-1), get(pipe_map, {x, y}) == "S" do
      {x, y}
    end
    |> List.first()
  end

  defp get_size(pipe_map) do
    x_size = tuple_size(pipe_map)
    y_size = tuple_size(elem(pipe_map, 0))

    {x_size, y_size}
  end

  defp get(pipe_map, {x, y}) do
    pipe_map
    |> elem(x)
    |> elem(y)
  end

  def find_neighbors(_pipe_map, {x, y} = _point) do
    [{x-1, y}, {x+1, y}]
  end
end
