defmodule AdventOfCode2023.Day08Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day08

  test "Day08 part A example 1" do
    assert Day08.part_a(example_input_1()) == 2
  end

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

  test "Day08 part B example" do
    assert Day08.part_b(example_input_part_b()) == 6
  end

  defp example_input_part_b() do
    [
      "LR",
      "",
      "11A = (11B, XXX)",
      "11B = (XXX, 11Z)",
      "11Z = (11B, XXX)",
      "22A = (22B, XXX)",
      "22B = (22C, 22C)",
      "22C = (22Z, 22Z)",
      "22Z = (22B, 22B)",
      "XXX = (XXX, XXX) "
    ]
  end

  test "Parse input" do
    assert Day08.parse_input(example_input_2()) ==
             {[0, 0, 1],
              %{
                "AAA" => {"BBB", "BBB"},
                "BBB" => {"AAA", "ZZZ"},
                "ZZZ" => {"ZZZ", "ZZZ"}
              }}
  end

  test "find starting nodes for part B" do
    map = %{
      "AAA" => {"ZZZ", "ZZZ"},
      "AAB" => {"ZZZ", "ZZZ"},
      "ZAA" => {"ZZZ", "ZZZ"},
      "ZZA" => {"ZZZ", "ZZZ"},
      "QAQ" => {"ZZZ", "ZZZ"},
      "CBA" => {"ZZZ", "ZZZ"}
    }

    assert Day08.find_starting_nodes(map) == ["AAA", "CBA", "ZAA", "ZZA"]
  end
end
