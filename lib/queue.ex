defmodule AdventOfCode2023.Queue do
  defstruct front: [], back: []

  def new(), do: %__MODULE__{}

  def empty?(%__MODULE__{front: [], back: []}), do: true
  def empty?(%__MODULE__{}), do: false

  def push(%__MODULE__{back: back} = queue, element), do: %__MODULE__{queue | back: [element | back]}

  def pop(%__MODULE__{front: [], back: []}), do: :empty

  def pop(%__MODULE__{front: [], back: back}), do: pop(%__MODULE__{front: Enum.reverse(back), back: []})

  def pop(%__MODULE__{front: [front_head | front_tail]} = queue) do
    {%__MODULE__{queue | front: front_tail}, front_head}
  end
end
