defmodule AdventOfCode2023.Day05Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day05

  test "Placeholder" do
    assert Day05.part_a("") == nil
  end
end

defmodule AdventOfCode2023.SeedMappingTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.SeedMapping

  test "A seed maps to the same number in the absense of any mappings" do
    seed_mapping = SeedMapping.new()

    assert SeedMapping.seed_to_location(seed_mapping, 6) == 6
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
end
