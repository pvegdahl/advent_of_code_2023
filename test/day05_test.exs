defmodule AdventOfCode2023.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day05

  test "AoC example part 1" do
    assert Day05.part_a(example_input()) == 35
  end

  defp example_input() do
    [
      "seeds: 79 14 55 13",
      "",
      "seed-to-soil map:",
      "50 98 2",
      "52 50 48",
      "",
      "soil-to-fertilizer map:",
      "0 15 37",
      "37 52 2",
      "39 0 15",
      "",
      "fertilizer-to-water map:",
      "49 53 8",
      "0 11 42",
      "42 0 7",
      "57 7 4",
      "",
      "water-to-light map:",
      "88 18 7",
      "18 25 70",
      "",
      "light-to-temperature map:",
      "45 77 23",
      "81 45 19",
      "68 64 13",
      "",
      "temperature-to-humidity map:",
      "0 69 1",
      "1 0 69",
      "",
      "humidity-to-location map:",
      "60 56 37",
      "56 93 4"
    ]
  end
end

defmodule AdventOfCode2023.SeedMappingTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.{OneMapping, SeedMapping}

  test "A seed maps to the same number in the absense of any mappings" do
    seed_mapping = SeedMapping.new([])

    assert SeedMapping.seed_to_location(seed_mapping, 6) == {:seed, 6}
  end

  test "Map a seed through one mapping" do
    seed_mapping = SeedMapping.new([OneMapping.new(:seed, :soil, [{11, 6, 4}])])

    assert SeedMapping.seed_to_location(seed_mapping, 8) == {:soil, 13}
  end

  test "Map a seed through multiple mappings" do
    seed_mapping =
      SeedMapping.new([
        OneMapping.new(:seed, :soil, [{11, 6, 4}]),
        OneMapping.new(:soil, :fertilizer, [{40, 11, 4}])
      ])

    assert SeedMapping.seed_to_location(seed_mapping, 8) == {:fertilizer, 42}
  end
end

defmodule AdventOfCode2023.OneMappingTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.OneMapping

  test "A number maps to the same number in the absense of any mappings" do
    mapping = OneMapping.new(:seed, :soil, [])

    assert OneMapping.next(mapping, :seed, 42) == {:soil, 42}
  end

  test "Return an error if we pass the wrong source type into the OneMapping" do
    mapping = OneMapping.new(:seed, :soil, [])

    assert OneMapping.next(mapping, :temperature, 13) == :error
  end

  test "The simplest mapping works" do
    mapping = OneMapping.new(:seed, :soil, [{47, 42, 1}])

    assert OneMapping.next(mapping, :seed, 42) == {:soil, 47}
  end

  test "Map a range" do
    mapping = OneMapping.new(:seed, :soil, [{86, 99, 10}])

    assert OneMapping.next(mapping, :seed, 101) == {:soil, 88}
  end

  test "Out of range" do
    mapping = OneMapping.new(:seed, :soil, [{86, 99, 10}])

    assert OneMapping.next(mapping, :seed, 44) == {:soil, 44}
  end

  test "Map multiple ranges" do
    mapping = OneMapping.new(:seed, :soil, [{86, 99, 10}, {47, 42, 3}])

    assert OneMapping.next(mapping, :seed, 43) == {:soil, 48}
  end

  test "Just inside range" do
    mapping = OneMapping.new(:seed, :soil, [{44, 33, 3}])

    assert OneMapping.next(mapping, :seed, 35) == {:soil, 46}
  end

  test "Just outside range" do
    mapping = OneMapping.new(:seed, :soil, [{44, 33, 3}])

    assert OneMapping.next(mapping, :seed, 36) == {:soil, 36}
  end
end
