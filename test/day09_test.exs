defmodule AdventOfCode2023.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day09

  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == 114
  end

  defp example_input() do
    [
      "0 3 6 9 12 15",
      "1 3 6 10 15 21",
      "10 13 16 21 30 45"
    ]
  end

  @tag :skip
  test "Day09 part B example" do
    assert Day09.part_b(example_input()) == 2
  end

  test "Parse example input" do
    assert Day09.parse_input(example_input()) == [
             [0, 3, 6, 9, 12, 15],
             [1, 3, 6, 10, 15, 21],
             [10, 13, 16, 21, 30, 45]
           ]
  end

  @example_nums [10, 13, 16, 21, 30, 45]

  test "Calculate list differences" do
    assert Day09.list_differences(@example_nums) == [3, 3, 5, 9, 15]
  end

  test "Calculate chain of differences" do
    assert Day09.difference_chain(@example_nums) == [
             @example_nums,
             [3, 3, 5, 9, 15],
             [0, 2, 4, 6],
             [2, 2, 2],
             [0, 0]
           ]
  end

  test "Calculate next value" do
    assert Day09.next_value(@example_nums) == 68
  end
end
