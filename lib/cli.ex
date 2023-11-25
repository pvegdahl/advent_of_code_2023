defmodule AdventOfCode2023.Cli do
  def run_day(day_number) do
    day_module =
      ("Elixir.AdventOfCode2023.Day" <> day_number)
      |> String.to_existing_atom()

    [run_a(day_module, day_number), run_b(day_module, day_number)]
    |> Enum.reject(&(&1 == nil))
    |> Enum.join("\n")
  end

  defp run_a(day_module, day_number) do
    run_function(day_module, day_number, :a)
  end

  defp run_b(day_module, day_number) do
    run_function(day_module, day_number, :b)
  end

  defp run_function(day_module, day_number, function_atom) do
    functions = day_module.__info__(:functions)

    if Enum.member?(functions, {function_atom, 0}) do
      "___Day" <> day_number <> "-" <> Atom.to_string(function_atom) <> "___\n" <> Function.capture(day_module, function_atom, 0).() <> "\n"
    else
      nil
    end
  end
end
