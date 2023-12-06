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

  test "Placeholder" do
    assert Day06.part_a("") == nil
  end
end