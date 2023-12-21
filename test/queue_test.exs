defmodule AdventOfCode2023.QueueTest do
  use ExUnit.Case, async: true

  alias AdventOfCode2023.Queue

  test "An empty queue is empty" do
    queue = Queue.new()
    assert Queue.empty?(queue)
  end
end
