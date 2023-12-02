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
  alias AdventOfCode2023.ColorCubes

  defstruct [:red]

  def from_text(text) do
    %ColorCubes{red: parse_red(text)}
  end

  defp parse_red(text) do
    case Regex.run(~r/(\d+) red/, text) do
      [_, count] -> String.to_integer(count)
    end
  end
end