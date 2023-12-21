defmodule AdventOfCode2023.Queue do
  defstruct is_empty: true, elements: []

  def new(), do: %__MODULE__{}

  def empty?(%__MODULE__{is_empty: is_empty}), do: is_empty

  def push(%__MODULE__{elements: elements}, element), do: %__MODULE__{is_empty: false, elements: [element | elements]}

  def pop(%__MODULE__{elements: elements}) do
    {remaining_elements, [front]} = Enum.split(elements, -1)
    {%__MODULE__{elements: remaining_elements}, front}
  end
end
