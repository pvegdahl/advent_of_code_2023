defmodule AdventOfCode2023.Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day01

  test "An input line with just two digits returns that number" do
    assert Day01.filter_line_to_number("34") == 34
  end

  test "An input line with just extra digits returns the outer digits as a number" do
    assert Day01.filter_line_to_number("9345") == 95
  end

  test "Filter out non-numbers to get the number" do
    assert Day01.filter_line_to_number("a8b6c") == 86
  end

  test "Process and add multiple lines" do
    assert Day01.add_lines(["34", "9345", "a8b6c"]) == 215
  end

  test "AoC example A" do
    assert Day01.add_lines(["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"]) == 142
  end

  test "One line with number words" do
    assert Day01.filter_line_with_number_words("abcone2threexyz") == 13
  end

  test "Sorted word matches" do
    assert Day01.sorted_word_matches("eightwothree") == ["eight", "two", "three"]

  end

  test "Word replacement happens in order" do
    assert Day01.filter_line_with_number_words("eightwothree") == 83
  end

  test "AoC example B" do
    assert Day01.add_lines_with_number_words([
             "two1nine",
             "eightwothree",
             "abcone2threexyz",
             "xtwone3four",
             "4nineeightseven2",
             "zoneight234",
             "7pqrstsixteen"
           ]) == 281
  end
end
