defmodule AdventOfCode2023.Day20Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day20
  alias AdventOfCode2023.Day20.Node

  @example_input_1 [
    "broadcaster -> a, b, c",
    "%a -> b",
    "%b -> c",
    "%c -> inv",
    "&inv -> a"
  ]

  @tag :skip
  test "Day20 part A example 1" do
    assert Day20.part_a(@example_input_1) == 32_000_000
  end

  @example_input_2 [
    "broadcaster -> a",
    "%a -> inv, con",
    "&inv -> b",
    "%b -> con",
    "&con -> output"
  ]

  @tag :skip
  test "Day20 part A example 2" do
    assert Day20.part_a(@example_input_2) == 11_687_500
  end

  @tag :skip
  test "Day20 part B example" do
    assert Day20.part_b(@example_input_1) == :something_else
  end

  test "A broadcaster sends the same plus to all destinations" do
    broadcaster = Node.new_broadcaster(~w(a b c))

    assert Node.send(broadcaster, {"button", :high, "broadcaster"}) ==
             {broadcaster,
              [
                {"broadcaster", :high, "a"},
                {"broadcaster", :high, "b"},
                {"broadcaster", :high, "c"}
              ]}
  end
end
