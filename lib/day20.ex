defmodule AdventOfCode2023.Day20 do
  alias AdventOfCode2023.Helpers

  def part_a(_lines) do
  end

  def parse_input(_lines) do
    # TODO!
  end

  def push_button(network) do
    {network, [low: Enum.count(network), high: 0]}
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

  def new_nand(destinations, sources) do
    last_source_pulses =
      sources
      |> Enum.map(&{&1, :low})
      |> Map.new()

    %__MODULE__{type: :nand, destinations: destinations, state: last_source_pulses}
  end

  def send(%__MODULE__{type: :broadcaster} = node, {pulse, _source, self_name}) do
    {node, multiplex(pulse, self_name, node)}
  end

  def send(%__MODULE__{type: :flip_flop} = node, {:high, _source, _self_name}) do
    {node, []}
  end

  def send(%__MODULE__{type: :flip_flop, state: state} = node, {:low, _source, self_name}) do
    {%__MODULE__{node | state: toggle_ff_state(state)}, multiplex(ff_state_to_pulse(state), self_name, node)}
  end

  def send(%__MODULE__{type: :nand, state: last_source_pulses} = node, {pulse, source, self_name}) do
    updated_node = %__MODULE__{node | state: Map.put(last_source_pulses, source, pulse)}
    next_pulse = nand_pulse(updated_node)

    {updated_node, multiplex(next_pulse, self_name, node)}
  end

  defp toggle_ff_state(:off), do: :on
  defp toggle_ff_state(:on), do: :off

  defp ff_state_to_pulse(:off), do: :high
  defp ff_state_to_pulse(:on), do: :low

  defp multiplex(pulse, source, %__MODULE{destinations: destinations}) do
    Enum.map(destinations, fn destination -> {pulse, source, destination} end)
  end

  defp nand_pulse(%__MODULE__{state: last_source_pulses}) do
    if Enum.all?(last_source_pulses, fn {_, pulse} -> pulse == :high end) do
      :low
    else
      :high
    end
  end
end
