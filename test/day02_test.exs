defmodule AdventOfCode2023.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day02

  test "AoC part A example" do
    assert Day02.part_a(example_lines()) == 8
  end

  defp example_lines() do
    [
      "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
      "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
      "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
      "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
      "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
    ]
  end

  test "AoC part B example" do
    assert Day02.part_b(example_lines()) == 2286
  end
end

defmodule AdventOfCode2023.ColorCubesTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.ColorCubes

  test "Parse red cubes from text" do
    assert ColorCubes.from_text("3 red") == %ColorCubes{red: 3, green: 0, blue: 0}
  end

  test "Parse green cubes from text" do
    assert ColorCubes.from_text("45 green") == %ColorCubes{red: 0, green: 45, blue: 0}
  end

  test "Parse blue cubes from text" do
    assert ColorCubes.from_text("16 blue") == %ColorCubes{red: 0, green: 0, blue: 16}
  end

  test "Parse all colors from text" do
    assert ColorCubes.from_text("1 blue, 2 green, 3 red") == %ColorCubes{red: 3, green: 2, blue: 1}
  end

  test "Parse a whole line" do
    assert ColorCubes.parse_line("Game 18: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") ==
             {18,
              [
                %ColorCubes{blue: 3, red: 4},
                %ColorCubes{red: 1, green: 2, blue: 6},
                %ColorCubes{green: 2}
              ]}
  end

  test "Find the max of each color across multiple ColorCubes" do
    color_cubes = [
      %ColorCubes{red: 1, green: 2, blue: 3},
      %ColorCubes{red: 11, green: 12, blue: 0},
      %ColorCubes{red: 1, green: 2, blue: 30},
      %ColorCubes{red: 7, green: 200, blue: 3}
    ]

    assert ColorCubes.max_by_color(color_cubes) == %ColorCubes{red: 11, green: 200, blue: 30}
  end

  test "One ColorCubes is strictly lte than itself" do
    cubes = %ColorCubes{red: 1, green: 2, blue: 3}

    assert ColorCubes.strictly_lte(cubes, cubes)
  end

  test "One ColorCubes is not strictly lte to another with mixed lte status" do
    cubes_a = %ColorCubes{red: 1, green: 3, blue: 1}
    cubes_b = %ColorCubes{red: 1, green: 2, blue: 3}

    assert not ColorCubes.strictly_lte(cubes_a, cubes_b)
  end

  test "One ColorCubes is strictly lte to another, different one that is lte across colors" do
    cubes_a = %ColorCubes{red: 1, green: 3, blue: 9}
    cubes_b = %ColorCubes{red: 4, green: 3, blue: 10}

    assert ColorCubes.strictly_lte(cubes_a, cubes_b)
  end

  test "Cube power is the multiplier of the cube values" do
    assert ColorCubes.power(%ColorCubes{red: 4, green: 3, blue: 10}) == 120
  end
end
