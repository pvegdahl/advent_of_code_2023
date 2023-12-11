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

  test "Day10 part A example 1" do
    assert Day10.part_a(@example_input_1) == 4
  end

  test "Day10 part A example 2" do
    assert Day10.part_a(@example_input_2) == 8
  end

  @example_input_3 [
    "...........",
    ".S-------7.",
    ".|F-----7|.",
    ".||.....||.",
    ".||.....||.",
    ".|L-7.F-J|.",
    ".|..|.|..|.",
    ".L--J.L--J.",
    "..........."
  ]

  defp pipe_map_3(), do: Day10.parse_input(@example_input_3)

  @example_input_4 [
    "..........",
    ".S------7.",
    ".|F----7|.",
    ".||....||.",
    ".||....||.",
    ".|L-7F-J|.",
    ".|..||..|.",
    ".L--JL--J.",
    ".........."
  ]

  defp pipe_map_4(), do: Day10.parse_input(@example_input_4)

  @example_input_5 [
    ".F----7F7F7F7F-7....",
    ".|F--7||||||||FJ....",
    ".||.FJ||||||||L7....",
    "FJL7L7LJLJ||LJ.L-7..",
    "L--J.L7...LJS7F-7L7.",
    "....F-J..F7FJ|L7L7L7",
    "....L7.F7||L7|.L7L7|",
    ".....|FJLJ|FJ|F7|.LJ",
    "....FJL-7.||.||||...",
    "....L---J.LJ.LJLJ..."
  ]

  defp pipe_map_5(), do: Day10.parse_input(@example_input_5)

  @tag :skip
  test "Day10 part B example 3" do
    assert Day10.part_b(@example_input_3) == 8
  end

  @tag :skip
  test "Day10 part B example 4" do
    assert Day10.part_b(@example_input_4) == 4
  end

  @tag :skip
  test "Day10 part B example 5" do
    assert Day10.part_b(@example_input_5) == 8
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
    assert Day10.find_start(pipe_map_2()) == {0, 2}
  end

  test "Find neighbors of a |" do
    assert Day10.find_neighbors(pipe_map_1(), {3, 2}) == [{3, 1}, {3, 3}]
  end

  test "Find neighbors of a -" do
    assert Day10.find_neighbors(pipe_map_1(), {2, 3}) == [{1, 3}, {3, 3}]
  end

  test "Find neighbors of an L" do
    assert Day10.find_neighbors(pipe_map_1(), {1, 3}) == [{1, 2}, {2, 3}]
  end

  test "Find neighbors of a J" do
    assert Day10.find_neighbors(pipe_map_1(), {3, 3}) == [{3, 2}, {2, 3}]
  end

  test "Find neighbors of a 7" do
    assert Day10.find_neighbors(pipe_map_1(), {3, 1}) == [{2, 1}, {3, 2}]
  end

  test "Find neighbors of an F" do
    assert Day10.find_neighbors(pipe_map_2(), {1, 3}) == [{2, 3}, {1, 4}]
  end

  test "A . has no neighbors" do
    assert Day10.find_neighbors(pipe_map_2(), {4, 4}) == []
  end

  test "Find neighbors of an S in example 1" do
    assert Day10.find_neighbors(pipe_map_1(), {1, 1}) == [{1, 2}, {2, 1}]
  end

  test "Find neighbors of an S in example 2" do
    assert Day10.find_neighbors(pipe_map_2(), {0, 2}) == [{0, 3}, {1, 2}]
  end

  test "Calculate enclosed area of a line with no enclosed area" do
    assert Day10.enclosed_area_of_line([[".", ".", ".", "."]], MapSet.new(), 0) == 0
  end
end
