defmodule AdventOfCode2023.Day07 do
  alias AdventOfCode2023.Helpers

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
    most_common_card_count =
      hand
      |> String.graphemes()
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.max()

    case most_common_card_count do
      5 -> :five_of_a_kind
      4 -> :four_of_a_kind
    end
  end
end
