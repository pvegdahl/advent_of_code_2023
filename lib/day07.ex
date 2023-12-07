defmodule AdventOfCode2023.Day07 do
  alias AdventOfCode2023.Helpers

  @hand_type_order %{
    :high_card => 0,
    :pair => 1,
    :two_pair => 2,
    :three_of_a_kind => 3,
    :full_house => 4,
    :four_of_a_kind => 5,
    :five_of_a_kind => 6
  }

  @card_rank_order %{
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14
  }

  def part_a(lines) do
    lines
    |> parse_input()
    |> sort_hands()
    |> Enum.map(&elem(&1, 1))
    |> Enum.with_index(1)
    |> Enum.map(fn {bid, index} -> bid * index end)
    |> Enum.sum()
  end

  defp parse_input(lines) do
    lines
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [hand, bid] -> {hand, String.to_integer(bid)} end)
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day07.txt")
    |> part_b()
  end

  def hand_type(hand) do
    card_counts =
      hand
      |> String.graphemes()
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)

    case card_counts do
      [5] -> :five_of_a_kind
      [4, 1] -> :four_of_a_kind
      [3, 2] -> :full_house
      [3, 1, 1] -> :three_of_a_kind
      [2, 2, 1] -> :two_pair
      [2, 1, 1, 1] -> :pair
      _ -> :high_card
    end
  end

  def sort_hands(hands) do
    Enum.sort_by(hands, &elem(&1, 0), &first_hand_precedes_second/2)
  end

  defp first_hand_precedes_second(hand_a, hand_b) do
    rank_a = hand_rank(hand_a)
    rank_b = hand_rank(hand_b)

    if rank_a == rank_b do
      precedes_by_card_order(hand_a, hand_b)
    else
      rank_a < rank_b
    end
  end

  defp hand_rank(hand) do
    hand_type = hand_type(hand)
    Map.get(@hand_type_order, hand_type)
  end

  defp precedes_by_card_order([head | a_tail], [head | b_tail]), do: precedes_by_card_order(a_tail, b_tail)

  defp precedes_by_card_order([a_head | _a_tail], [b_head | _b_tail]) do
    Map.get(@card_rank_order, a_head) < Map.get(@card_rank_order, b_head)
  end

  defp precedes_by_card_order(hand_a, hand_b) when is_binary(hand_a) and is_binary(hand_b) do
    precedes_by_card_order(String.graphemes(hand_a), String.graphemes(hand_b))
  end
end
