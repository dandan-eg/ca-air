# Un à la fois
defmodule Exercice do
  def remove_duplicate_ajdacent(<<>>), do: <<>>
  def remove_duplicate_ajdacent(<<_char>> = string), do: string

  def remove_duplicate_ajdacent(<<char, remaining::binary>>) do
    do_remove_duplicate_adjacent(char, remaining, <<>>)
  end

  defp do_remove_duplicate_adjacent(current, <<current, remaining::binary>>, acc) do
    do_remove_duplicate_adjacent(current, remaining, acc)
  end

  defp do_remove_duplicate_adjacent(current, <<next, remaining::binary>>, acc) do
    do_remove_duplicate_adjacent(next, remaining, <<acc::binary, current>>)
  end

  defp do_remove_duplicate_adjacent(current, <<>>, acc) do
    <<acc::binary, current>>
  end

  def run do
    case System.argv() do
      [string] ->
        string
        |> Exercice.remove_duplicate_ajdacent()
        |> IO.puts()

      _bad_args ->
        IO.puts("usage: elixir air04.exs <string>")
    end
  end
end

Exercice.run()
