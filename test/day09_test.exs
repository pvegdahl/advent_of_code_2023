defmodule AdventOfCode2023.Day09Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day09

  @tag :skip
  test "Day09 part A example" do
    assert Day09.part_a(example_input()) == :something
  end

  defp example_input() do
    [
      "TODO"
    ]
  end

  @tag :skip
  test "Day09 part B example" do
    assert Day09.part_b(example_input()) == :something_else
  end
end
