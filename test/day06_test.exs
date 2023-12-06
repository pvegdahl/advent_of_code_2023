defmodule AdventOfCode2023.SearchRangeTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.SearchRange

  test "Returns the whole range when all values are true" do
    assert SearchRange.range_of_true(4..88, fn _ -> true end) == 4..88
  end

  test "Truncate false results from the front" do
    assert SearchRange.range_of_true(1..100, fn n -> n > 16 end) == 17..100
  end

  test "Truncate false results from the back" do
    assert SearchRange.range_of_true(1..100, fn n -> n < 86 end) == 1..85
  end

  test "Truncate front and back" do
    assert SearchRange.range_of_true(1..100, fn n -> 33 < n and n < 66 end) == 34..65
  end
end

defmodule AdventOfCode2023.Day06Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day06

  test "parse day 06A input" do
    assert Day06.parse_input_a(example_input()) == [{7, 9}, {15, 40}, {30, 200}]
  end

  defp example_input() do
    [
      "Time:      7  15   30",
      "Distance:  9  40  200"
    ]
  end

  test "Create our test function fails at the lower boundary" do
    assert not Day06.create_test_func(7, 9).(1)
  end

  test "Create our test function passes at the lower boundary" do
    assert Day06.create_test_func(7, 9).(2)
  end

  test "Create our test function passes at the upper boundary" do
    assert Day06.create_test_func(7, 9).(5)
  end

  test "Create our test function fails at the upper boundary" do
    assert not Day06.create_test_func(7, 9).(6)
  end

  test "Count success times" do
    assert Day06.count_win_options(7, 9) == 4
    assert Day06.count_win_options(15, 40) == 8
    assert Day06.count_win_options(30, 200) == 9
  end

  test "Example part A" do
    assert Day06.part_a(example_input()) == 288
  end

  @tag :skip
  test "Example part B" do
    assert Day06.part_b(example_input()) == 71503
  end
end
