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

  def part_a(_lines) do
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
    Enum.sort(hands, &first_hand_precedes_second/2)
  end

  defp first_hand_precedes_second(hand_a, hand_b), do: hand_rank(hand_a) <= hand_rank(hand_b)

  defp hand_rank(hand) do
    hand_type = hand_type(hand)
    Map.get(@hand_type_order, hand_type)
  end
end
