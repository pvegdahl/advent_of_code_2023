defmodule AdventOfCode2023.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day09

  @tag :skip
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
    assert Day09.part_b(example_input()) == :something_else
  end
end
