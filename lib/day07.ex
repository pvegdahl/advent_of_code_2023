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
    "W" => 0,  # Wildcards are transformed to W when in use
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

  def hand_type("WWWWW"), do: :five_of_a_kind

  def hand_type(hand) do
    card_counts =
      hand
      |> String.graphemes()
      |> Enum.frequencies()
      |> use_wildcards()
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

  defp use_wildcards(hand_frequencies) do
    wildcard_count = Map.get(hand_frequencies, "W", 0)
    no_wildcards = Map.delete(hand_frequencies, "W")

    most_frequent_card =
      no_wildcards
      |> Map.to_list()
      |> Enum.max_by(&elem(&1, 1))
      |> elem(0)

      Map.update!(no_wildcards, most_frequent_card, &(&1 + wildcard_count))
  end

  def sort_hands(hands) do
    Enum.sort_by(hands, &elem(&1, 0), &first_hand_precedes_second/2)
  end

  defp first_hand_precedes_second(hand_a, hand_b) do
    comparison_helper(hand_a, hand_b, [&compare_by_hand_type/2, &compare_by_card_order/2])
  end

  defp comparison_helper(hand_a, hand_b, [comparison_func_head | comparison_func_tail]) do
    case comparison_func_head.(hand_a, hand_b) do
      :lt -> true
      :gt -> false
      :eq -> comparison_helper(hand_a, hand_b, comparison_func_tail)
    end
  end

  defp comparison_helper(hand_a, hand_b, [rank_func_head | rank_func_tail]) do
    rank_a = rank_func_head.(hand_a)
    rank_b = rank_func_head.(hand_b)

    cond do
      rank_a < rank_b -> :lt
      rank_a > rank_b -> :gt
      rank_a == rank_b -> :eq
    end
  end

  defp compare_by_hand_type(hand_a, hand_b) do
    rank_a = hand_rank(hand_a)
    rank_b = hand_rank(hand_b)

    cond do
      rank_a < rank_b -> :lt
      rank_a > rank_b -> :gt
      rank_a == rank_b -> :eq
    end
  end

  defp hand_rank(hand) do
    hand_type = hand_type(hand)
    Map.get(@hand_type_order, hand_type)
  end

  defp compare_by_card_order([head | a_tail], [head | b_tail]), do: compare_by_card_order(a_tail, b_tail)

  defp compare_by_card_order([a_head | _a_tail], [b_head | _b_tail]) do
    rank_a = Map.get(@card_rank_order, a_head)
    rank_b = Map.get(@card_rank_order, b_head)

    cond do
      rank_a < rank_b -> :lt
      rank_a > rank_b -> :gt
      rank_a == rank_b -> :eq
    end
  end

  defp compare_by_card_order(hand_a, hand_b) when is_binary(hand_a) and is_binary(hand_b) do
    compare_by_card_order(String.graphemes(hand_a), String.graphemes(hand_b))
  end
end
