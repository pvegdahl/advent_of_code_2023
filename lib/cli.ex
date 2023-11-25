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
    functions = day_module.__info__(:functions)

    if Enum.member?(functions, {:a, 0}) do
      "___Day" <> day_number <> "-a___\n" <> Function.capture(day_module, :a, 0).() <> "\n"
    else
      nil
    end
  end

  defp run_b(day_module, day_number) do
    functions = day_module.__info__(:functions)

    if Enum.member?(functions, {:b, 0}) do
      "___Day" <> day_number <> "-b___\n" <> Function.capture(day_module, :b, 0).() <> "\n"
    else
      nil
    end
  end
end
