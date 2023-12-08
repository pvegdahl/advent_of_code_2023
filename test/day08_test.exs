defmodule AdventOfCode2023.Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day08

  @tag :skip
  test "Day08 part A example" do
    assert Day08.part_a(example_input()) == :something
  end

  defp example_input() do
    [
      "TODO"
    ]
  end

  @tag :skip
  test "Day08 part B example" do
    assert Day08.part_b(example_input()) == :something_else
  end
end
