# Concat
defmodule Exercice do
  def concat(list, delimiter) do
    do_concat(list, delimiter, <<>>)
  end

  defp do_concat([head], _delimiter, acc) do
    <<acc::binary, head::bitstring>>
  end

  defp do_concat([head | tail], delimiter, acc) do
    do_concat(
      tail,
      delimiter,
      <<acc::binary, head::bitstring, delimiter::bitstring>>
    )
  end

  defp do_concat([], _delimiter, acc), do: acc

  def run do
    case System.argv() do
      [] ->
        IO.puts("usage: elixir air03.exs <args..> <delemiter>")

      [_] ->
        IO.puts("usage: elixir air03.exs <args..> <delemiter>")

      args ->
        {delimiter, list} = List.pop_at(args, -1)

        list
        |> Exercice.concat(delimiter)
        |> IO.inspect()
    end
  end
end
