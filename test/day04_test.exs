defmodule AdventOfCode2023.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day04

  test "Parse a line into winning numbers and my numbers" do
    assert Day04.parse_line("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1") == [
             [1, 21, 53, 59, 44],
             [69, 82, 63, 72, 16, 21, 14, 1]
           ]
  end

  test "Score one line" do
    assert Day04.score_line("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53") == 8
  end

  test "Score a line with no matches" do
    assert Day04.score_line("Card 42: 41 48 83 86 17 | 1 2 3 4 5 6 7 8 9") == 0
  end

  test "Part A example" do
    assert Day04.part_a(example_input()) == 13
  end

  defp example_input() do
    [
      "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
      "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
      "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
      "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
      "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
      "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"
    ]
  end

  test "Parse into a list of match counts" do
    assert Day04.parse_to_counts(example_input()) == [4, 2, 2, 1, 0, 0]
  end

  test "Given a simple match counts of zero, return the correct number of cards" do
    assert Day04.matches_to_card_counts([0, 0, 0, 0, 0]) == 5
  end
end
