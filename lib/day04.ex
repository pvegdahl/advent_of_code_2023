defmodule AdventOfCode2023.Day04 do
  alias AdventOfCode2023.Helpers

  def part_a(lines) do
    lines
    |> Enum.map(&score_line/1)
    |> Enum.sum()
  end

  def score_line(line) do
    case match_count(line) do
      0 -> 0
      pos_number -> Integer.pow(2, pos_number - 1)
    end
  end

  defp match_count(line) do
    line
    |> parse_line()
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.size()
  end

  def parse_line(line) do
    line
    |> String.split(":")
    |> Enum.at(1)
    |> String.split("|")
    |> Enum.map(&numbers_string_to_list/1)
  end

  defp numbers_string_to_list(numbers_string) do
    numbers_string
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def part_b(_lines) do
  end

  def parse_to_counts(lines), do: Enum.map(lines, &match_count/1)

  def matches_to_card_counts(matches) do
    matches
    |> Enum.map(&{1, &1})
    |> match_count_helper()
  end

  def match_count_helper([]), do: 0

  def match_count_helper([{count, score} | tail]) do
    new_card_list = update_card_list(tail, count, score)
    count + match_count_helper(new_card_list)
  end

  defp update_card_list([], _extra_cards, _depth), do: []
  defp update_card_list(card_list, _extra_cards, 0), do: card_list

  defp update_card_list([{card_count, card_score} | cards_tail], extra_cards, depth) do
    [{card_count + extra_cards, card_score} | update_card_list(cards_tail, extra_cards, depth - 1)]
  end

  def a() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day04.txt")
    |> part_b()
  end
end
