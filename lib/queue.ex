defmodule AdventOfCode2023.Queue do
  defstruct is_empty: true

  def new(), do: %__MODULE__{}

  def empty?(%__MODULE__{is_empty: is_empty}), do: is_empty

  def push(queue, _element), do: %__MODULE__{queue | is_empty: false}
end
