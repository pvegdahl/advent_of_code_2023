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

    assert Node.send(broadcaster, {:high, "button", "broadcaster"}) ==
             {broadcaster,
              [
                {:high, "broadcaster", "a"},
                {:high, "broadcaster", "b"},
                {:high, "broadcaster", "c"}
              ]}
  end

  test "A flip flop sends nothing when it receives a high pulse" do
    flip_flop = Node.new_flip_flop(~w(a z))

    assert {flip_flop, []} == Node.send(flip_flop, {:high, "source", "self"})
  end
end
