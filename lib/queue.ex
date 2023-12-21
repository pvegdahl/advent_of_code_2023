defmodule AdventOfCode2023.Queue do
  defstruct elements: []

  def new(), do: %__MODULE__{}

  def empty?(%__MODULE__{elements: []}), do: true
  def empty?(%__MODULE__{elements: _}), do: false

  def push(%__MODULE__{elements: elements}, element), do: %__MODULE__{elements: [element | elements]}

  def pop(%__MODULE__{elements: []}), do: :empty

  def pop(%__MODULE__{elements: elements}) do
    {remaining_elements, [front]} = Enum.split(elements, -1)
    {%__MODULE__{elements: remaining_elements}, front}
  end
end
