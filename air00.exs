defmodule Exercice do
  def split(string) do
    do_split(string, <<>>, [])
  end

  defguardp is_whitespace(char) when char in [?\r, ?\n, ?\s]

  defp do_split(<<char, rest::binary>>, <<>>, acc) when is_whitespace(char) do
    do_split(rest, <<>>, acc)
  end

  defp do_split(<<char, rest::binary>>, word, acc) when is_whitespace(char) do
    do_split(rest, <<>>, [word | acc])
  end

  defp do_split(<<char, rest::binary>>, word, acc) do
    do_split(rest, <<word::binary, char>>, acc)
  end

  defp do_split(<<>>, word, acc) do
    Enum.reverse([word | acc])
  end
end

case System.argv() do
  [string] ->
    string
    |> Exercice.split()
    |> IO.inspect()

  _bad_args ->
    IO.puts("Usage: elixir air00.exs <sentence>")
end
