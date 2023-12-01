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

  test "AoC example" do
    assert Day01.add_lines(["1abc2", "pqr3stu8vwx", "a1b2c3d4e5f", "treb7uchet"]) == 142
  end
end
