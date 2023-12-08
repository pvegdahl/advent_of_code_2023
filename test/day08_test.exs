defmodule AdventOfCode2023.Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day08

  @tag :skip
  test "Day08 part A example 1" do
    assert Day08.part_a(example_input_1()) == 2
  end

  @tag :skip
  test "Day08 part A example 2" do
    assert Day08.part_a(example_input_2()) == 6
  end

  defp example_input_1() do
    [
      "RL",
      "",
      "AAA = (BBB, CCC)",
      "BBB = (DDD, EEE)",
      "CCC = (ZZZ, GGG)",
      "DDD = (DDD, DDD)",
      "EEE = (EEE, EEE)",
      "GGG = (GGG, GGG)",
      "ZZZ = (ZZZ, ZZZ)"
    ]
  end

  defp example_input_2() do
    [
      "LLR",
      "",
      "AAA = (BBB, BBB)",
      "BBB = (AAA, ZZZ)",
      "ZZZ = (ZZZ, ZZZ)"
    ]
  end

  @tag :skip
  test "Day08 part B example 1" do
    assert Day08.part_b(example_input_1()) == :something_else
  end

  @tag :skip
  test "Day08 part B example 2" do
    assert Day08.part_b(example_input_2()) == :something_else
  end
end
