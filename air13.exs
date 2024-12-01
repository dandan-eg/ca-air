scripts = [
  {"air00.exs", [["“Bonjour les gars"]]},
  {"air01.exs", [["Crevette magique dans la mer des étoiles", "la"]]},
  {"air02.exs", [["1", "2", "2", "2", "2"], ["1", "1"]]},
  {"air03.exs", [["Je", "gros", "et", "moche", "+"], ["Tu", "es", "trop", "fort", "--"]]},
  {"air04.exs", [["Jeeeeee suis beau"], ["Cooddiiiing"]]},
  {"air05.exs", [["1", "2", "3", "4", "5", "+1"], ["10", "20", "30", "-5"]]},
  {"air06.exs", [["Courage", "Rapide", "Jeune", "ra"], ["Eliot", "Arthur", "Leo", "e"]]},
  {"air07.exs", [["1", "2", "3", "5", "4"], ["-1", "0", "2", "1"]]},
  {"air08.exs", [["1", "5", "9", "fusion", "2", "3", "4"]]},
  {"air09.exs", [["1", "2", "3"], ["Eliot", "Martin", "George"]]},
  {"air10.exs", [["*", "10"], ["-", "4"]]},
  {"air11.exs", [["air00.exs"]]},
  {"air12.exs", [["2", "0", "-3", "98", "11", "11"], ["1", "22", "9", "9"]]},
  # skip "air13.exs"
  {"air14.exs", [[]]}
]

defmodule Exercice do
  def puts_red(message), do: "#{IO.ANSI.red()}#{message}#{IO.ANSI.reset()}" |> IO.puts()

  def puts_green(message),
    do: "#{IO.ANSI.green()}#{message}#{IO.ANSI.reset()}" |> IO.puts()

  def execute_file(filename, args) do
    case System.cmd("elixir", [filename | args]) do
      {result, 0} ->
        puts_green("#{filename} OK: #{result}")

      {_, bad_exit} ->
        puts_red("#{filename} with #{inspect(args)} returned #{bad_exit}")
    end
  end
end

Enum.each(scripts, fn {filename, args_set} ->
  Enum.each(args_set, fn args ->
    Exercice.execute_file(filename, args)
  end)
end)
