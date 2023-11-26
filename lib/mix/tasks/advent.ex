defmodule Mix.Tasks.Advent do
  @moduledoc "A custom mix task to run code for a specific day (Totally unnecessary)"
  use Mix.Task

  @shortdoc "For now, just outputs a test string"
  def run(_) do
    IO.puts("It works!")
  end
end