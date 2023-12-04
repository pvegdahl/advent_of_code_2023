defmodule AdventOfCode2023.TemplateGenerator.Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.TemplateGenerator

  test "Generate a source template" do
    assert TemplateGenerator.source("42") == """
           defmodule AdventOfCode2023.Day42 do
             alias AdventOfCode2023.Helpers

             def part_a(_lines) do
             end

             def part_b(_lines) do
             end

             def a() do
               Helpers.file_to_lines!("inputs/day42.txt")
               |> part_a()
             end

             def b() do
               Helpers.file_to_lines!("inputs/day42.txt")
               |> part_b()
             end
           end
           """
  end

  test "Generate a test template" do
    assert TemplateGenerator.test("47") == """
           defmodule AdventOfCode2023.Day47Test do
             use ExUnit.Case, async: true

             alias AdventOfCode2023.Day47

             test "Placeholder" do
               assert Day47.part_a("") == nil
             end
           end
           """
  end

  test "Create a filename for a source file" do
    assert TemplateGenerator.source_file_name("86") == "day86.ex"
  end
end
