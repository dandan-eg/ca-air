# Sur chacun d'entre eux
defmodule Exercice do
  def parse_args([]), do: {:error, :bad_args}
  def parse_args([_arg]), do: {:error, :bad_args}

  def parse_args(args) do
    do_parse_args(args, [])
  end

  defp do_parse_args([], [mapper | tail]) do
    {:ok, mapper, Enum.reverse(tail)}
  end

  defp do_parse_args([arg | tail], acc) do
    case str_to_int(arg, 0) do
      :error -> {:error, {:nan, arg}}
      number -> do_parse_args(tail, [number | acc])
    end
  end

  defp str_to_int(<<"+", remaining::binary>>, 0) do
    str_to_int(remaining, 0)
  end

  defp str_to_int(<<"-", remaining::binary>>, 0) do
    -str_to_int(remaining, 0)
  end

  defp str_to_int(<<char, remaining::binary>>, accumulator) when char in ?0..?9 do
    str_to_int(remaining, accumulator * 10 + char - 48)
  end

  defp str_to_int(<<_invalid_char, _remaining::binary>>, _accumulator), do: :error

  defp str_to_int(<<>>, accumulator), do: accumulator

  def apply(numbers, mapper), do: do_apply(numbers, mapper, [])

  defp do_apply([head | tail], mapper, acc), do: do_apply(tail, mapper, [head + mapper | acc])
  defp do_apply([], _mapper, acc), do: Enum.reverse(acc)
end

System.argv()
|> Exercice.parse_args()
|> case do
  {:ok, mapper, numbers} ->
    numbers
    |> Exercice.apply(mapper)
    |> IO.inspect()

  {:error, {:nan, arg}} ->
    IO.puts("#{arg} is not a valid number")

  {:error, :bad_args} ->
    IO.puts("usage: elixir eau05.exs <numbers..> <apply>")
end
