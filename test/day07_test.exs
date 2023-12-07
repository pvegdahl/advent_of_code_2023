defmodule AdventOfCode2023.Day07Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day07

  @tag :skip
  test "Day07 part A example" do
    assert Day07.part_a(example_input()) == :something
  end

  defp example_input() do
    [
      "TODO"
    ]
  end

  @tag :skip
  test "Day07 part B example" do
    assert Day07.part_b(example_input()) == :something_else
  end
end
