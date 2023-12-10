defmodule AdventOfCode2023.Day10Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day10

  @tag :skip
  test "Day10 part A example" do
    assert Day10.part_a(example_input()) == :something
  end

  defp example_input() do
    [
      "TODO"
    ]
  end

  @tag :skip
  test "Day10 part B example" do
    assert Day10.part_b(example_input()) == :something_else
  end
end
