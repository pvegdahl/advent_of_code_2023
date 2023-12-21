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

    assert_pops(queue, [1, 2, 3])
  end

  defp assert_pops(queue, []), do: assert Queue.pop(queue) == :empty

  defp assert_pops(queue, [head | tail]) do
    assert {new_queue, head} = Queue.pop(queue)
    assert_pops(new_queue, tail)
  end

  test "Attempting to pop an empty queue returns :empty" do
    assert Queue.pop(Queue.new()) == :empty
  end

  test "Push many puts the elements on the queue with the first one in the enum popping first" do
    queue =
      Queue.new()
      |> Queue.push_many(1..5)
  end
end
