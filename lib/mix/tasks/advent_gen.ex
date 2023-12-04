defmodule Mix.Tasks.Advent.Gen do
  @moduledoc "A custom mix task to generate code for a new day"
  use Mix.Task

  alias AdventOfCode2023.TemplateGenerator

  @shortdoc "Generate a source and test file for a new day"
  def run([day]) do
    File.write!(TemplateGenerator.source_file_path(day), TemplateGenerator.source(day))
    File.write!(TemplateGenerator.test_file_path(day), TemplateGenerator.test(day))
  end
end
