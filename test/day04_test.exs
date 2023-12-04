defmodule AdventOfCode2023.Day04Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day04

  test "Parse a line into winning numbers and my numbers" do
    assert Day04.parse_line("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1") == [
             [1, 21, 53, 59, 44],
             [69, 82, 63, 72, 16, 21, 14,  1]]
  end
end
