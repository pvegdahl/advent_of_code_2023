defmodule AdventOfCode2023.Day01 do
  @number_mappings %{
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
    "0" => 0,
    "1" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9
  }

  def filter_line_to_number(line) do
    line
    |> String.graphemes()
    |> Enum.map(&Integer.parse/1)
    |> Enum.reject(&(&1 == :error))
    |> Enum.map(fn {digit, _} -> digit end)
    |> first_and_last()
    |> Integer.undigits()
  end

  defp first_and_last(list), do: [List.first(list), List.last(list)]

  def part_a(lines) do
    lines
    |> Enum.map(&filter_line_to_number/1)
    |> Enum.sum()
  end

  def part_b(lines) do
    lines
    |> Enum.map(&filter_line_with_number_words/1)
    |> Enum.sum()
  end

  def filter_line_with_number_words(line) do
    line
    |> sorted_word_matches()
    |> first_and_last()
    |> Enum.map(&Map.get(@number_mappings, &1))
    |> Integer.undigits()
  end

  defp file_to_lines(filename) do
    File.stream!(filename, [:utf8])
    |> Stream.map(&String.trim/1)
  end

  def sorted_word_matches(line) do
    @number_mappings
    |> Map.keys()
    |> Enum.flat_map(fn word -> find_indexes_of_match(line, word) end)
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.map(&elem(&1, 1))
  end

  defp find_indexes_of_match(line, word) do
    Regex.compile!(word)
    |> Regex.scan(line, return: :index)
    |> Enum.map(fn [{index, _}] -> {index, word} end)
  end

  def a() do
    file_to_lines("inputs/day01.txt")
    |> part_a()
  end

  def b() do
    file_to_lines("inputs/day01.txt")
    |> part_b()
  end
end
