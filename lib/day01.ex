defmodule AdventOfCode2023.Day01 do
  @number_word_to_number %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
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

  def add_lines(lines) do
    lines
    |> Enum.map(&filter_line_to_number/1)
    |> Enum.sum()
  end

  def filter_line_with_number_words(line) do
    line
    |> replace_number_word_with_number()
    |> filter_line_to_number()
  end

  defp replace_number_word_with_number(line) do
    new_line = do_one_replacement(line)

    if new_line == line do
      new_line
    else
      replace_number_word_with_number(new_line)
    end
  end

  def add_lines_with_number_words(lines) do
    lines
    |> Enum.map(&filter_line_with_number_words/1)
    |> Enum.sum()
  end

  defp file_to_lines(filename) do
    File.stream!(filename, [:utf8])
    |> Stream.map(&String.trim/1)
  end

  defp do_one_replacement(line) do
    first_match = get_first_match(line)

    if first_match != nil do
      regex = Regex.compile!(first_match)
      replacement = Map.get(@number_word_to_number, first_match)

      Regex.replace(regex, line, replacement, global: false)
    else
      line
    end
  end

  defp get_first_match(line) do
    line
    |> sorted_word_matches()
    |> List.first()
  end

  def sorted_word_matches(line) do
    @number_word_to_number
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
    |> add_lines()
  end

  def b() do
    file_to_lines("inputs/day01.txt")
    |> add_lines_with_number_words()
  end
end
