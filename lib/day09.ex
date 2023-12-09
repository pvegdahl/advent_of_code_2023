defmodule AdventOfCode2023.Day09 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day09.txt")
    |> part_b()
  end

  def parse_input(lines) do
    lines
    |> Enum.map(&Helpers.string_to_int_list/1)
  end

  def list_differences([head | tail]) do
    Enum.scan(tail, {0, head}, fn x, {_result, prev_x} -> {x - prev_x, x} end)
    |> Enum.map(&elem(&1, 0))
  end

  def difference_chain(nums) do
    if Enum.all?(nums, &(&1 == 0)) do
      []
    else
      next_nums = list_differences(nums)
      [next_nums | difference_chain(next_nums)]
    end
  end
end
