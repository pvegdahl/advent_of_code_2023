
defmodule AdventOfCode2023.Day02Test do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Day02
end


defmodule AdventOfCode2023.ColorCubesTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.ColorCubes

  test "Parse red cubes from text" do
    assert ColorCubes.from_text("3 red") == %ColorCubes{red: 3}
  end
end
