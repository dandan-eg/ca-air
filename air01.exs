defmodule Exercice do
  def split(string, delimiter) do
    do_split(string, delimiter, <<>>, [])
  end

  defp do_split(<<>>, _delimiter, part, acc) do
    Enum.reverse([part | acc])
  end

  defp do_split(string, delimiter, part, acc) do
    size = byte_size(delimiter)

    case string do
      <<^delimiter::binary-size(size), remaining::binary>> ->
        do_split(remaining, delimiter, <<>>, [part | acc])

      <<char, remaining::binary>> ->
        do_split(remaining, delimiter, <<part::binary, char>>, acc)
    end
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
