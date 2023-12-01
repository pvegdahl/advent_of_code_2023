defmodule AdventOfCode2023.Day01Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day01

  test "An input line with just two digits returns that number" do
    assert Day01.filter_line_to_number("34") == 34
  end

  test "An input line with just extra digits returns the outer digits as a number" do
    assert Day01.filter_line_to_number("9345") == 95
  end
end