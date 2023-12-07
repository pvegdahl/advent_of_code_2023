defmodule AdventOfCode2023.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day07

  @tag :skip
  test "Day07 part A example" do
    assert Day07.part_a(example_input()) == 6440
  end

  defp example_input() do
    [
      "32T3K 765",
      "T55J5 684",
      "KK677 28",
      "KTJJT 220",
      "QQQJA 483"
    ]
  end

  @tag :skip
  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == :something_else
  end
end
