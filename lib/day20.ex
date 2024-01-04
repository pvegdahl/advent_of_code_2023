defmodule AdventOfCode2023.Day20 do
  alias AdventOfCode2023.Helpers
  alias AdventOfCode2023.Queue
  alias AdventOfCode2023.Day20.Node

  def part_a(_lines) do
  end

  def parse_input(lines) do
    reverve_map = lines_to_reverse_map(lines)

    lines
    |> Enum.map(&line_to_node(&1, reverve_map))
    |> Map.new()
  end

  defp lines_to_reverse_map(lines) do
    lines
    |> Enum.map(&line_to_tuple/1)
    |> Map.new()
    |> Helpers.reverse_map_of_lists()
  end

  defp line_to_tuple(line) do
    [node_name | destination_nodes] =
      line
      |> String.split(["->", ","])
      |> Enum.map(&String.trim/1)

    {remove_prefix(node_name), destination_nodes}
  end

  defp remove_prefix(<<"&"::binary, name::binary>>), do: name
  defp remove_prefix(<<"%"::binary, name::binary>>), do: name
  defp remove_prefix(name), do: name

  defp line_to_node(line, reverse_map) do
    [node_name | destination_nodes] =
      line
      |> String.split(["->", ","])
      |> Enum.map(&String.trim/1)

    new_node(node_name, destination_nodes, reverse_map)
  end

  defp new_node(name, destination_nodes, reverse_map)

  defp new_node("broadcaster", destination_nodes, _reverse_map) do
    {"broadcaster", Node.new_broadcaster(destination_nodes)}
  end

  defp new_node(<<"&"::binary, name::binary>>, destination_nodes, reverse_map) do
    {name, Node.new_nand(destination_nodes, Map.get(reverse_map, name, []))}
  end

  defp new_node(<<"%"::binary, name::binary>>, destination_nodes, _reverse_map) do
    {name, Node.new_flip_flop(destination_nodes)}
  end

  def push_button(network) do
    queue = Queue.new() |> Queue.push({:low, "button", "broadcaster"})
    process_pulses(network, queue)
  end

  defp process_pulses(network, queue, low \\ 0, high \\ 0) do
    case Queue.pop(queue) do
      :empty -> {network, [low: low, high: high]}
      {popped_queue, pulse_spec} -> process_one_pulse(network, popped_queue, pulse_spec, low, high)
    end
  end

  defp process_one_pulse(network, queue, {pulse, _source, destination} = pulse_spec, low, high) do
    {new_low, new_high} = update_low_high(low, high, pulse)

    case Map.get(network, destination, nil) do
      nil ->
        process_pulses(network, queue, new_low, new_high)

      node ->
        {updated_node, new_pulses} = Node.send(node, pulse_spec)

        process_pulses(
          Map.put(network, destination, updated_node),
          Queue.push_many(queue, new_pulses),
          new_low,
          new_high
        )
    end
  end

  defp update_low_high(low, high, :low), do: {low + 1, high}
  defp update_low_high(low, high, :high), do: {low, high + 1}

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
