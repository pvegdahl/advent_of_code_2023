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

  test "Pop the same element that was added to a queue" do
    queue =
      Queue.new()
      |> Queue.push(47)

    assert {%Queue{}, 47} = Queue.pop(queue)
  end

  test "Pop elements in FIFO order" do
    queue =
      Queue.new()
      |> Queue.push(1)
      |> Queue.push(2)
      |> Queue.push(3)

    assert {queue_pop1, 1} = Queue.pop(queue)
    assert {queue_pop2, 2} = Queue.pop(queue_pop1)
    assert {_queue_pop3, 3} = Queue.pop(queue_pop2)
  end

  test "Attempting to pop an empty queue returns :empty" do
    assert Queue.pop(Queue.new()) == :empty
  end
end
