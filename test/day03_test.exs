defmodule AdventOfCode2023.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day03

  test "Get a * symbol location from a line" do
    line = "...*..."
    assert Day03.get_symbol_locations(line, 14) == %{{3, 14} => "*"}
  end

  test "Get multiple * symbol locations from a line" do
    line = "*.*.*.*"
    assert Day03.get_symbol_locations(line, 3) == %{{0, 3} => "*", {2, 3} => "*", {4, 3} => "*", {6, 3} => "*"}
  end
end
