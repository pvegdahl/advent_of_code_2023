defmodule AdventOfCode2023.ColorCubes do
  defstruct red: 0, green: 0, blue: 0

  def parse_line(line) do
    [game_text, cube_text] = String.split(line, ":")

    {parse_game_number(game_text), parse_cubes(cube_text)}
  end

  def from_text(text) do
    args =
      text
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&parse_color/1)

    struct(__MODULE__, args)
  end

  def max_by_color(cubes) do
    args =
      [:red, :green, :blue]
      |> Enum.map(fn color -> {color, max_of_color(cubes, color)} end)

    struct(__MODULE__, args)
  end

  def strictly_lte(%__MODULE__{red: r0, green: g0, blue: b0}, %__MODULE__{red: r1, green: g1, blue: b1}) do
    r0 <= r1 && g0 <= g1 && b0 <= b1
  end

  def power(%__MODULE__{red: red, green: green, blue: blue}), do: red * green * blue

  defp max_of_color(cubes, color) do
    cubes
    |> Enum.map(&Map.get(&1, color))
    |> Enum.max()
  end

  defp parse_color(text) do
    case String.split(text, " ") do
      [count, color] -> {String.to_existing_atom(color), String.to_integer(count)}
    end
  end

  defp parse_cubes(cube_text) do
    cube_text
    |> String.split(";")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&from_text/1)
  end

  defp parse_game_number(game_text) do
    game_text
    |> String.split(" ")
    |> Enum.at(1)
    |> String.to_integer()
  end
end

defmodule AdventOfCode2023.Day02 do
  alias AdventOfCode2023.Helpers
  alias AdventOfCode2023.ColorCubes

  @part_a_target %ColorCubes{red: 12, green: 13, blue: 14}

  def part_a(lines) do
    lines
    |> Stream.map(&ColorCubes.parse_line/1)
    |> Stream.filter(fn {_game_number, cubes} -> game_passes?(cubes) end)
    |> Stream.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp game_passes?(cubes) do
    cubes
    |> ColorCubes.max_by_color()
    |> ColorCubes.strictly_lte(@part_a_target)
  end

  def part_b(lines) do
    lines
    |> Stream.map(&ColorCubes.parse_line/1)
    |> Stream.map(&elem(&1, 1))
    |> Stream.map(&ColorCubes.max_by_color/1)
    |> Stream.map(&ColorCubes.power/1)
    |> Enum.sum()
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
