defmodule AdventOfCode2023.SearchRangeTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.SearchRange

  test "Returns the whole range when all values are true" do
    assert SearchRange.range_of_true(4..88, fn _ -> true end) == 4..88
  end
end

defmodule AdventOfCode2023.Day06Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day06

  test "Placeholder" do
    assert Day06.part_a("") == nil
  end
end