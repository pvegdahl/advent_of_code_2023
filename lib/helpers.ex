defmodule AdventOfCode2023.Helpers do
  def file_to_lines!(filename) do
    File.stream!(filename, [:utf8])
    |> Stream.map(&String.trim/1)
  end
end