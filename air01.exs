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

  def run do
    case System.argv() do
      [string] ->
        string
        |> Exercice.split()
        |> IO.inspect()

      _bad_args ->
        IO.puts("Usage: elixir air00.exs <sentence>")
    end
  end
end

Exercice.run()
