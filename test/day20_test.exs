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

  test "A flip flop sends a high pulse after the first low pulse" do
    flip_flop = Node.new_flip_flop(~w(a z))

    assert {%Node{type: :flip_flop}, [{:high, "self", "a"}, {:high, "self", "z"}]} =
             Node.send(flip_flop, {:low, "source", "self"})
  end

  test "On low pulses, a flip flop will alternate pulses" do
    ff0 = Node.new_flip_flop(["q"])

    assert {ff1, [{:high, "ff", "q"}]} = Node.send(ff0, {:low, "source", "ff"})
    assert {ff2, [{:low, "ff", "q"}]} = Node.send(ff1, {:low, "source", "ff"})
    assert {ff3, [{:high, "ff", "q"}]} = Node.send(ff2, {:low, "source", "ff"})
    assert {_ff4, [{:low, "ff", "q"}]} = Node.send(ff3, {:low, "source", "ff"})
  end

  test "A simple nand (conjunction) node with just one input will invert the input pulse" do
    nand = Node.new_nand(~w(y z), ["a"])

    assert {%Node{type: :nand}, [{:high, "nand", "y"}, {:high, "nand", "z"}]} = Node.send(nand, {:low, "a", "nand"})
    assert {%Node{type: :nand}, [{:low, "nand", "y"}, {:low, "nand", "z"}]} = Node.send(nand, {:high, "a", "nand"})
  end

  test "A nand with two inputs will send high pulses when only one input is high" do
    nand = Node.new_nand(["z"], ["a", "b"])

    assert {%Node{type: :nand}, [{:high, "nand", "z"}]} = Node.send(nand, {:high, "a", "nand"})
    assert {%Node{type: :nand}, [{:high, "nand", "z"}]} = Node.send(nand, {:high, "b", "nand"})
  end

  test "A nand with two inputs will send low pulses when both inputs go high" do
    nand0 = Node.new_nand(["z"], ["a", "b"])

    assert {nand1, [{:high, "nand", "z"}]} = Node.send(nand0, {:high, "a", "nand"})
    assert {_nand2, [{:low, "nand", "z"}]} = Node.send(nand1, {:high, "b", "nand"})
  end

  test "A nand with two inputs goes back to high when one input goes low again" do
    nand0 = Node.new_nand(["z"], ["a", "b"])

    {nand1, _} = Node.send(nand0, {:high, "a", "nand"})
    {nand2, _} = Node.send(nand1, {:high, "b", "nand"})
    assert {_nand3, [{:high, "nand", "z"}]} = Node.send(nand2, {:low, "b", "nand"})
  end

  test "Count high and low pulses of one push in a very simple broadcaster + 1 network" do
    network = Day20.parse_input(["broadcaster -> a"])
    assert {_new_network, [low: 2, high: 0]} = Day20.push_button(network)
  end

  test "Count high and low pulses of one push in a very simple broadcaster + 2 network" do
    network = Day20.parse_input(["broadcaster -> a, b"])
    assert {_new_network, [low: 3, high: 0]} = Day20.push_button(network)
  end

  test "push_button of broadcaster to nand to other is 2 low plus one high" do
    network = Day20.parse_input(["broadcaster -> nand", "&nand -> a"])
    assert {_new_network, [low: 2, high: 1]} = Day20.push_button(network)
  end

  test "push_button of broadcaster to nand to nand to other is 3 low plus one high" do
    network = Day20.parse_input(["broadcaster -> nand1", "&nand1 -> nand2", "&nand2 -> a"])
    assert {_new_network, [low: 3, high: 1]} = Day20.push_button(network)
  end

  test "push_button of broadcaster to flip flop to other is 2 low plus 1 high" do
    network = Day20.parse_input(["broadcaster -> ff", "%ff -> a"])
    assert {_new_network, [low: 2, high: 1]} = Day20.push_button(network)
  end
end
