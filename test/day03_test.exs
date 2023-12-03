defmodule AdventOfCode2023.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day03

  test "Get a * symbol location from a line" do
    line = "...*..."
    assert Day03.get_symbol_locations(line, 14) == %{{3, 14} => "*"}
  end
end
