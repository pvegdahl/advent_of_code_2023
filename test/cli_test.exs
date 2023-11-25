defmodule AdventOfCode2023.CliTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Cli

  test "Run the proper day's code" do
    assert Cli.run_day("0") == "day0 part_a"
  end
end
