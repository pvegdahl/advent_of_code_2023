defmodule AdventOfCode2023.TemplateGenerator do
  def source(day) do
    """
    defmodule AdventOfCode2023.Day#{day} do
      alias AdventOfCode2023.Helpers

      def part_a(_lines) do
      end

      def part_b(_lines) do
      end

      def a() do
        Helpers.file_to_lines!("inputs/day#{day}.txt")
        |> part_a()
      end

      def b() do
        Helpers.file_to_lines!("inputs/day#{day}.txt")
        |> part_b()
      end
    end
    """
  end

  def test(day) do
    """
    defmodule AdventOfCode2023.Day#{day}Test do
      use ExUnit.Case, async: true

      alias AdventOfCode2023.Day#{day}

      test "Placeholder" do
        assert Day#{day}.part_a("") == nil
      end
    end
    """
  end

  def source_file_name(day), do: "day#{day}.ex"

  def test_file_name(day), do: "day#{day}_test.exs"
end
