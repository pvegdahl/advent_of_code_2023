defmodule AdventOfCode2023.Day20Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day20

  @tag :skip
  test "Day20 part A example" do
    assert Day20.part_a(example_input()) == :something
  end

  defp example_input() do
    [
      "TODO"
    ]
  end

  @tag :skip
  test "Day20 part B example" do
    assert Day20.part_b(example_input()) == :something_else
  end
end
