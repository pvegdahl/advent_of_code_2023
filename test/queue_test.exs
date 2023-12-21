defmodule AdventOfCode2023.QueueTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Queue

  test "An empty queue is empty" do
    queue = Queue.new()
    assert Queue.empty?(queue)
  end

  test "A non empty queue is not empty" do
    queue =
      Queue.new()
      |> Queue.push(6)

    assert not Queue.empty?(queue)
  end
end
