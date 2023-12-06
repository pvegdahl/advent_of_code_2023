defmodule AdventOfCode2023.SearchRange do
  def range_of_true(first..last = range, is_true?) do
    new_first = Enum.find(range, is_true?)
    new_last = Enum.find(last..first, is_true?)

    new_first..new_last
  end
end

defmodule AdventOfCode2023.Day06 do
  alias AdventOfCode2023.{Helpers, SearchRange}

  def part_a(lines) do
    lines
    |> parse_input_a()
    |> Enum.map(fn {time, record_distance} -> count_win_options(time, record_distance) end)
    |> Enum.product()
  end

  def parse_input_a(lines) do
    ["Time:" <> times_string, "Distance:" <> distances_string] = lines
    times = Helpers.string_to_int_list(times_string)
    distances = Helpers.string_to_int_list(distances_string)

    Enum.zip(times, distances)
  end

  def create_test_func(time, record_distance) do
    fn n -> n * (time - n) > record_distance end
  end

  def count_win_options(time, record_distance) do
    is_true? = create_test_func(time, record_distance)
    win_range = SearchRange.range_of_true(1..(time-1), is_true?)

    Enum.count(win_range)
  end

  def part_b(_lines) do
  end

  def parse_input_b(lines) do
    ["Time:" <> time_string, "Distance:" <> distance_string] = lines
    {string_with_spaces_to_single_integer(time_string), string_with_spaces_to_single_integer(distance_string)}
  end

  defp string_with_spaces_to_single_integer(integer_string) do
    integer_string
    |> String.replace(" ", "")
    |> String.to_integer()
  end

  def a() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> Enum.to_list()
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day06.txt")
    |> part_b()
  end
end
