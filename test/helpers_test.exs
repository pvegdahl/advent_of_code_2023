defmodule AdventOfCode2023.HelpersTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Helpers

  test "A reversed map of lists with one key and one value" do
    assert Helpers.reverse_map_of_lists(%{1 => [2]}) == %{2 => [1]}
  end

  test "A reversed map of lists with two keys, each with one distinct value" do
    assert Helpers.reverse_map_of_lists(%{1 => [2], 3 => [4]}) == %{2 => [1], 4 => [3]}
  end
end
