defmodule AdventOfCode2023.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day02
  alias AdventOfCode2023.ColorCubes

  describe "Color Cubes" do
    test "Parse one color of cubes from text" do
      assert ColorCubes.from_text("3 red") == %ColorCubes{red: 3}
    end
  end
end
