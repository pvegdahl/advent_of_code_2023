defmodule AdventOfCode2023.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day07

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

  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == 5905
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

  test "Detect five of a kind with wildcards" do
    assert Day07.hand_type("2W2WW") == :five_of_a_kind
  end

  test "Detect three of a kind with wildcards" do
    assert Day07.hand_type("234WW") == :three_of_a_kind
  end

  test "Sort hands of distinct types" do
    hands = [
      {"22333", 1},
      {"55555", 2},
      {"22AKQ", 3},
      {"33356", 4},
      {"22JJT", 5},
      {"23456", 6},
      {"4444T", 7}
    ]

    expected = [
      {"23456", 6},
      {"22AKQ", 3},
      {"22JJT", 5},
      {"33356", 4},
      {"22333", 1},
      {"4444T", 7},
      {"55555", 2}
    ]

    assert Day07.sort_hands(hands) == expected
  end

  test "Sort hands of the overlapping types" do
    hands = [
      {"22222", 1},
      {"AAA23", 2},
      {"JJJAK", 3},
      {"92223", 4},
      {"65432", 5},
      {"23465", 6},
      {"23456", 7},
      {"TJJJ2", 8}
    ]

    expected = [
      {"23456", 7},
      {"23465", 6},
      {"65432", 5},
      {"92223", 4},
      {"TJJJ2", 8},
      {"JJJAK", 3},
      {"AAA23", 2},
      {"22222", 1}
    ]

    assert Day07.sort_hands(hands) == expected
  end

  test "Wildcards sort lowest in card order" do
    hands = [
      {"2345W", 1},
      {"23W45", 2},
      {"W2345", 3},
      {"2W345", 4},
      {"234W5", 5}
    ]

    expected = [
      {"W2345", 3},
      {"2W345", 4},
      {"23W45", 2},
      {"234W5", 5},
      {"2345W", 1}
    ]

    assert Day07.sort_hands(hands) == expected
  end
end
