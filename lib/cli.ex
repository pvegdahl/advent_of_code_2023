defmodule AdventOfCode2023.Cli do
  def run_day(day_number) do
    day_module =
      ("Elixir.AdventOfCode2023.Day" <> day_number)
      |> String.to_existing_atom()

    functions = day_module.__info__(:functions)

    if Enum.member?(functions, {:a, 0}) do
      Function.capture(day_module, :a, 0).()
    else
      nil
    end
  end
end
