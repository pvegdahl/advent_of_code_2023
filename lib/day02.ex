defmodule AdventOfCode2023.Day02 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day02.txt")
    |> part_b()
  end
end

defmodule AdventOfCode2023.ColorCubes do
  defstruct red: 0, green: 0

  def from_text(text) do
    {color, count} = parse_color(text)
    struct(__MODULE__, [{color, count}])
  end

  defp parse_color(text) do
    case String.split(text, " ") do
      [count, color] -> {String.to_existing_atom(color), String.to_integer(count)}
    end
  end
end