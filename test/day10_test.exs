defmodule AdventOfCode2023.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day10

  @tag :skip
  test "Day10 part A example 1" do
    assert Day10.part_a(example_input_1()) == 4
  end

  defp example_input_1() do
    [
      ".....",
      ".S-7.",
      ".|.|.",
      ".L-J.",
      "....."
    ]
  end

  @tag :skip
  test "Day10 part A example 2" do
    assert Day10.part_a(example_input_2()) == 8
  end

  defp example_input_2() do
    [
      "..F7.",
      ".FJ|.",
      "SJ.L7",
      "|F--J",
      "LJ..."
    ]
  end

  @tag :skip
  test "Day10 part B example" do
    assert Day10.part_b(example_input_1()) == :something_else
  end

  test "parse example 1 input" do
    assert Day10.parse_input(example_input_1()) == {
             {".", ".", ".", ".", "."},
             {".", "S", "-", "7", "."},
             {".", "|", ".", "|", "."},
             {".", "L", "-", "J", "."},
             {".", ".", ".", ".", "."},
           }
  end
end
