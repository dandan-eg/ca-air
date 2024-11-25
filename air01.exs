# Split en fonction
defmodule Exercice do
  def split(string, pattern) do
    do_split(string, pattern, <<>>, [])
  end

  defguardp is_pattern_match(string, pattern)

  defp do_split(<<>>, _pattern, part, accumulator) do
    Enum.reverse([part | accumulator])
  end

  defp do_split(string, pattern, part, accumulator)
       when binary_part(string, 0, byte_size(pattern)) == pattern do
    rest = binary_part(string, byte_size(pattern), byte_size(string) - 1)
    do_split(rest, pattern, <<>>, [part | accumulator])
  end

  defp do_split(<<char, rest::binary>>, pattern, part, accumulator) do
    do_split(rest, pattern, <<part::binary, char>>, accumulator)
  end
end

case System.argv() do
  [string, pattern] ->
    string
    |> Exercice.split(pattern)
    |> IO.inspect()

  _bad_args ->
    IO.puts("usage: elixir air01.exs <string> <pattern>")
end
