defmodule AdventOfCode2023.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day05

  test "AoC example part A" do
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

  test "AoC example part B" do
    assert Day05.part_b(example_input()) == 46
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

defmodule AdventOfCode2023.RangeSetTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.RangeSet

  test "Split overlapping without overlap" do
    assert RangeSet.split_overlapping([1..10], 15..20) == {[], [1..10]}
  end

  test "Split overlapping with exact match" do
    assert RangeSet.split_overlapping([1..10], 1..10) == {[1..10], []}
  end

  test "Split overlapping with a comparison larger than target" do
    assert RangeSet.split_overlapping([5..10], 1..15) == {[5..10], []}
  end

  test "Split overlapping half match at start" do
    assert RangeSet.split_overlapping([1..10], 0..5) == {[1..5], [6..10]}
  end

  test "Split overlapping half match at end" do
    assert RangeSet.split_overlapping([1..10], 5..11) == {[5..10], [1..4]}
  end

  test "Split overlapping half match at start -- exact start match" do
    assert RangeSet.split_overlapping([1..10], 1..5) == {[1..5], [6..10]}
  end

  test "Split overlapping half match at end -- exact end match" do
    assert RangeSet.split_overlapping([1..10], 5..10) == {[5..10], [1..4]}
  end

  test "Split overlapping middle split" do
    assert RangeSet.split_overlapping([17..34], 20..30) == {[20..30], [17..19, 31..34]}
  end

  test "Multiple input ranges" do
    assert RangeSet.split_overlapping([1..5, 10..20, 25..30], 4..26) == {[4..5, 10..20, 25..26], [1..3, 27..30]}
  end

  test "Splits with single element result ranges" do
    assert RangeSet.split_overlapping([1..2], 0..1) == {[1..1], [2..2]}
  end

  test "Shift a whole RangeSet" do
    assert RangeSet.shift([1..5, 10..20, 25..30], 13) == [14..18, 23..33, 38..43]
  end

  test "Shift overlapping" do
    assert RangeSet.shift_overlapping([1..5, 10..20, 25..30], 4..26, 5) == [9..10, 15..25, 30..31, 1..3, 27..30]
  end

  test "Rangeset min" do
    assert RangeSet.min([100..200, 12..20, 25..30]) == 12
  end
end
