defmodule AdventOfCode2023.Day03Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day03

  test "Get a * symbol location from a line" do
    line = "...*..."
    assert Day03.get_symbol_locations(line, 14) == %{{3, 14} => "*"}
  end

  test "Get multiple * symbol locations from a line" do
    line = "*.*.*.*"
    assert Day03.get_symbol_locations(line, 3) == %{{0, 3} => "*", {2, 3} => "*", {4, 3} => "*", {6, 3} => "*"}
  end

  test "Get all symbols, even if we don't know the symbol types ahead of time" do
    line = "%.$#.*"
    assert Day03.get_symbol_locations(line, 7) == %{{0, 7} => "%", {2, 7} => "$", {3, 7} => "#", {5, 7} => "*"}
  end

  test "Get all symbol locations across the whole example input" do
    assert Day03.get_all_symbol_locations(example_lines()) == %{
             {2, 1} => "*",
             {5, 3} => "#",
             {2, 4} => "*",
             {4, 5} => "+",
             {3, 8} => "$",
             {5, 8} => "*"
           }
  end

  defp example_lines() do
    [
      "467..114..",
      "..*......",
      ".35..633.",
      ".....#...",
      "17*......",
      "....+.58.",
      ".592.....",
      ".....755.",
      "...$.*....",
      ".664.598.."
    ]
  end

  test "Get a single digit number and location from a line" do
    assert Day03.get_number_locations("..7...", 4) == {
             %{{2, 4} => {2, 4}},
             %{{2, 4} => 7}
           }
  end

  test "Get a multiple digit number and locations from a line" do
    assert Day03.get_number_locations(".123...", 9) == {
             %{{1, 9} => {1, 9}, {2, 9} => {1, 9}, {3, 9} => {1, 9}},
             %{{1, 9} => 123}
           }
  end

  test "Get multiple numbers and locations from a line" do
    assert Day03.get_number_locations("86..99", 5) == {
             %{{0, 5} => {0, 5}, {1, 5} => {0, 5}, {4, 5} => {4, 5}, {5, 5} => {4, 5}},
             %{{0, 5} => 86, {4, 5} => 99}
           }
  end

  test "Handles a line with no numbers" do
    assert Day03.get_number_locations(".#..$..%.*", 11) == {%{}, %{}}
  end

  test "Get numbers from multiple lines" do
    assert Day03.get_all_number_locations(["..3.", "12.*"]) == {
             %{{2, 0} => {2, 0}, {0, 1} => {0, 1}, {1, 1} => {0, 1}},
             %{{2, 0} => 3, {0, 1} => 12}
           }
  end

  test "Get neighbors of coordinates" do
    assert Day03.get_neighbors([{1, 1}, {3, 2}]) ==
             MapSet.new([
               {0, 0},
               {0, 1},
               {0, 2},
               {1, 0},
               {1, 2},
               {2, 0},
               {2, 1},
               {2, 2},
               {2, 3},
               {3, 1},
               {3, 3},
               {4, 1},
               {4, 2},
               {4, 3}
             ])
  end

  @tag :skip
  test "Part A example input" do
    assert Day03.part_a(example_lines()) == 4361
  end
end
