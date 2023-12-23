defmodule AdventOfCode2023.Day20 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def part_b(_lines) do
  end

  def a() do
    Helpers.file_to_lines!("inputs/day20.txt")
    |> part_a()
  end

  def b() do
    Helpers.file_to_lines!("inputs/day20.txt")
    |> part_b()
  end
end

defmodule AdventOfCode2023.Day20.Node do
  defstruct type: :broadcaster, destinations: []

  def new_broadcaster(destinations), do: %__MODULE__{destinations: destinations}

  def send(%__MODULE__{destinations: destinations} = node, {_source, pulse, self_name}) do
    new_pulses =
      destinations
      |> Enum.map(fn destination -> {self_name, pulse, destination} end)

    {node, new_pulses}
  end
end
