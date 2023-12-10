defmodule AdventOfCode2023.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day10

  @example_input_1 [
    ".....",
    ".S-7.",
    ".|.|.",
    ".L-J.",
    "....."
  ]

  defp pipe_map_1(), do: Day10.parse_input(@example_input_1)

  @example_input_2 [
    "..F7.",
    ".FJ|.",
    "SJ.L7",
    "|F--J",
    "LJ..."
  ]

  defp pipe_map_2(), do: Day10.parse_input(@example_input_2)

  @tag :skip
  test "Day10 part A example 1" do
    assert Day10.part_a(@example_input_1) == 4
  end

  @tag :skip
  test "Day10 part A example 2" do
    assert Day10.part_a(@example_input_2) == 8
  end

  @tag :skip
  test "Day10 part B example" do
    assert Day10.part_b(@example_input_1) == :something_else
  end

  test "parse example 1 input" do
    assert Day10.parse_input(@example_input_1) == {
             {".", ".", ".", ".", "."},
             {".", "S", "-", "7", "."},
             {".", "|", ".", "|", "."},
             {".", "L", "-", "J", "."},
             {".", ".", ".", ".", "."}
           }
  end

  test "Find the starting point of example input 1" do
    assert Day10.find_start(pipe_map_1()) == {1, 1}
  end

  test "Find the starting point of example input 2" do
    assert Day10.find_start(pipe_map_2()) == {2, 0}
  end

  test "Find neighbors of a |" do
    assert Day10.find_neighbors(pipe_map_1(), {2, 3}) == [{1, 3}, {3, 3}]
  end
end
