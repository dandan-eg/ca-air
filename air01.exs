# Split en fonction
defmodule Exercice do
  def split(string, delimiter) do
    do_split(string, delimiter, <<>>, [])
  end

  defp do_split(<<>>, _delimiter, part, accumulator) do
    Enum.reverse([part | accumulator])
  end

  defp do_split(string, delimiter, part, accumulator)
       when binary_part(string, 0, byte_size(delimiter)) == delimiter do
    rest = binary_part(string, byte_size(delimiter), byte_size(string) - 1)
    do_split(rest, delimiter, <<>>, [part | accumulator])
  end

  defp do_split(<<char, rest::binary>>, delimiter, part, accumulator) do
    do_split(rest, delimiter, <<part::binary, char>>, accumulator)
  end
end

case System.argv() do
  [string, delimiter] ->
    string
    |> Exercice.split(delimiter)
    |> IO.inspect()

  _bad_args ->
    IO.puts("usage: elixir air01.exs <string> <delimiter>")
end
