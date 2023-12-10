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

  @example_input_2 [
    "..F7.",
    ".FJ|.",
    "SJ.L7",
    "|F--J",
    "LJ..."
  ]

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
    pipe_map = Day10.parse_input(@example_input_1)
    assert Day10.find_start(pipe_map) == {1, 1}
  end

  test "Find the starting point of example input 2" do
    pipe_map = Day10.parse_input(@example_input_2)
    assert Day10.find_start(pipe_map) == {2, 0}
  end
end
