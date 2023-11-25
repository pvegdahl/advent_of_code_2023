defmodule AdventOfCode2023.Cli do
  def run_day(day_number) do
    get_day_module(day_number)
    |> run_all_functions(day_number)
  end

  defp get_day_module(day_number) do
    ("Elixir.AdventOfCode2023.Day" <> day_number)
    |> String.to_existing_atom()
  end

  defp run_all_functions(day_module, day_number) do
    day_module.__info__(:functions)
    |> Enum.filter(fn {_function_atom, arity} -> arity == 0 end)
    |> Enum.map(fn {function_atom, _arity} -> function_atom end)
    |> Enum.sort()
    |> Enum.map(&run_function(day_module, day_number, &1))
    |> Enum.join("\n")

  end

  defp run_function(day_module, day_number, function_atom) do
    "___Day" <>
      day_number <>
      "-" <> Atom.to_string(function_atom) <> "___\n" <> Function.capture(day_module, function_atom, 0).() <> "\n"
  end
end
