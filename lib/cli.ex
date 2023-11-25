defmodule AdventOfCode2023.Cli do
  def run_day(day_number) do
    day_module =
      ("Elixir.AdventOfCode2023.Day" <> day_number)
      |> String.to_existing_atom()

    functions = day_module.__info__(:functions)

    if Enum.member?(functions, {:a, 0}) do
      "___Day" <> day_number <> "-a___\n" <> Function.capture(day_module, :a, 0).() <> "\n"
    else
      nil
    end
  end
end
