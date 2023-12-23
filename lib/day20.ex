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
  defstruct [:type, :destinations, :state]

  def new_broadcaster(destinations), do: %__MODULE__{type: :broadcaster, destinations: destinations}

  def new_flip_flop(destinations), do: %__MODULE__{type: :flip_flop, destinations: destinations, state: :off}

  def send(%__MODULE__{type: :broadcaster, destinations: destinations} = node, {pulse, _source, self_name}) do
    {node, multiplex(pulse, self_name, destinations)}
  end

  def send(%__MODULE__{type: :flip_flop, state: :off} = node, {:high, _source, _self_name}) do
    {node, []}
  end

  defp multiplex(pulse, source, destinations) do
    Enum.map(destinations, fn destination -> {pulse, source, destination} end)
  end
end
