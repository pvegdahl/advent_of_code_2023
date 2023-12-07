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

  test "Detect five of a kind" do
    assert Day07.hand_type("QQQQQ") == :five_of_a_kind
  end

  test "Detect four of a kind" do
    assert Day07.hand_type("4444Q") == :four_of_a_kind
  end

  test "Detect a full house" do
    assert Day07.hand_type("A2A2A") == :full_house
  end

  test "Detect three of a kind" do
    assert Day07.hand_type("JJAJK") == :three_of_a_kind
  end

  test "Detect two pair" do
    assert Day07.hand_type("34543") == :two_pair
  end

  test "Detect a single pair" do
    assert Day07.hand_type("67898") == :pair
  end

  test "Detect a high card" do
    assert Day07.hand_type("AKQJT") == :high_card
  end
end
