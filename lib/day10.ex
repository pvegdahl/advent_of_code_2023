defmodule AdventOfCode2023.Day10 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    lines
    |> parse_input()
    |> find_loop()
    |> MapSet.size()
    |> div(2)
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

  defp get(_pipe_map, {-1, _y}), do: "."
  defp get(_pipe_map, {_x, -1}), do: "."

  defp get(pipe_map, {x, y}) do
    pipe_map
    |> elem(y)
    |> elem(x)
  end

  def find_neighbors(pipe_map, point) do
    case get(pipe_map, point) do
      "|" -> [up(point), down(point)]
      "-" -> [left(point), right(point)]
      "L" -> [up(point), right(point)]
      "J" -> [up(point), left(point)]
      "7" -> [left(point), down(point)]
      "F" -> [right(point), down(point)]
      "." -> []
      "S" -> s_neighbors(pipe_map, point)
    end
  end

  defp s_neighbors(pipe_map, point) do
    [up(point), down(point), left(point), right(point)]
    |> Enum.map(&{&1, find_neighbors(pipe_map, &1)})
    |> Enum.filter(fn {_neighbor, neighbors_neighbors} -> Enum.member?(neighbors_neighbors, point) end)
    |> Enum.map(fn {neighbor, _neighbors_neighbors} -> neighbor end)
    |> Enum.sort()
  end

  defp up({x, y}), do: {x, y - 1}
  defp down({x, y}), do: {x, y + 1}
  defp left({x, y}), do: {x - 1, y}
  defp right({x, y}), do: {x + 1, y}

  def find_loop(pipe_map) do
    start = find_start(pipe_map)
    find_loop_helper(pipe_map, start, MapSet.new([start]))
  end

  defp find_loop_helper(pipe_map, next_point, so_far) do
    new_neighbors =
      find_neighbors(pipe_map, next_point)
      |> MapSet.new()
      |> MapSet.difference(so_far)

    if MapSet.size(new_neighbors) == 0 do
      so_far
    else
      find_loop_helper(pipe_map, Enum.at(new_neighbors, 0), MapSet.union(so_far, new_neighbors))
    end
  end

  def enclosed_area_of_line(pipe_map, loop, line_num) do
    loop_points_on_this_line = Enum.filter(loop, fn {_x, y} -> y == line_num end)

    Enum.reduce(loop_points_on_this_line, {0, nil, :outside}, fn point, acc -> enclosed_area_reduce_helper(pipe_map, point, acc) end)
    |> elem(0)
  end

  defp enclosed_area_reduce_helper(pipe_map, point, {0, nil, :outside}) do
    case get(pipe_map, point) do
      "|" -> {0, point, :inside}
      "F" -> {0, point, :outside}
    end
  end

  defp enclosed_area_reduce_helper(pipe_map, point, {count, last_relevant_point, :outside}) do
    last_type = get(pipe_map, last_relevant_point)
    this_type =  get(pipe_map, point)
    case {last_type, this_type} do
      {"|", "|"} -> {count, point, :inside}
      {"7", "|"} -> {count, point, :inside}
      {"F", "7"} -> {count, point, :outside}
      {"F", "-"} -> {count, last_relevant_point, :outside}
      {_, "F"} -> {count, point, :outside}
    end
  end

  defp enclosed_area_reduce_helper(pipe_map, point, {count, last_relevant_point, :inside}) do
    last_type = get(pipe_map, last_relevant_point)
    this_type =  get(pipe_map, point)
    case {last_type, this_type} do
      {"|", "|"} -> {count + inside_count(last_relevant_point, point), point, :outside}
      {"7", "|"} -> {count + inside_count(last_relevant_point, point), point, :outside}
      {"F", "7"} -> {count, point, :inside}
      {"F", "-"} -> {count, last_relevant_point, :inside}
      {"|", "F"} -> {count + inside_count(last_relevant_point, point), point, :inside}
    end
  end

  defp inside_count({x0, _y0}, {x1, _y1}), do: x1 - x0 - 1
end
