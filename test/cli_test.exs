defmodule AdventOfCode2023.CliTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Cli

  test "Run the proper day's code" do
    assert Cli.run_day("0") == """
           ___Day0-a___
           day0 part_a
           """
  end

  test "Run parts A and B when they both exist" do
    assert Cli.run_day("00") == """
           ___Day00-a___
           AAA

           ___Day00-b___
           BBB
           """
  end
end
