defmodule AdventOfCode2023.Queue do
  defstruct is_empty: true, element: nil

  def new(), do: %__MODULE__{}

  def empty?(%__MODULE__{is_empty: is_empty}), do: is_empty

  def push(queue, element), do: %__MODULE__{queue | is_empty: false, element: element}

  def pop(%__MODULE__{element: element} = queue), do: {queue, element}
end
