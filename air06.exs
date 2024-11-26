defmodule Exercice do
  def parse_args([]), do: {:error, :bad_args}
  def parse_args([_arg]), do: {:error, :bad_args}

  def parse_args(args) do
    {discriminant, strings} = List.pop_at(args, -1)
    {:ok, strings, discriminant}
  end

  def filter_containing(strings, discriminant) do
    do_filter_containing(strings, discriminant, [])
  end

  defp do_filter_containing([], _discriminant, acc), do: Enum.reverse(acc)

  defp do_filter_containing([head | tail], discriminant, acc) do
    if contain?(String.upcase(head), String.upcase(discriminant)) do
      do_filter_containing(tail, discriminant, acc)
    else
      do_filter_containing(tail, discriminant, [head | acc])
    end
  end

  defp contain?(<<>>, _discrimiant), do: false
  defp contain?(string, discrimiant) when byte_size(discrimiant) > byte_size(string), do: false

  defp contain?(string, discrimiant) do
    size = byte_size(discrimiant)

    case string do
      <<^discrimiant::binary-size(size), _::binary>> -> true
      <<_, remaining::binary>> -> contain?(remaining, discrimiant)
    end
  end
end

System.argv()
|> Exercice.parse_args()
|> case do
  {:ok, strings, discriminant} ->
    strings
    |> Exercice.filter_containing(discriminant)
    |> IO.inspect()

  {:error, :bad_args} ->
    IO.puts("usage: elixir <string1> <string2> <string[...]")

  {:error, {:nan, arg}} ->
    IO.puts("\"#{arg}\" is not a number")
end
