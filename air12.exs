defmodule Exercice do
  def quicksort([]), do: []
  def quicksort([_] = numbers), do: numbers

  def quicksort([pivot | tail]) do
    {left, right} = partition(tail, pivot, [], [])
    quicksort(left) ++ [pivot] ++ quicksort(right)
  end

  defp partition([], _pivot, left, right), do: {left, right}

  defp partition([head | tail], pivot, left, right) do
    if head <= pivot do
      partition(tail, pivot, [head | left], right)
    else
      partition(tail, pivot, left, [head | right])
    end
  end

  defp parse_args([]), do: {:error, :no_args}

  defp parse_args(args) do
    do_parse_args(args, [])
  end

  defp do_parse_args([head | tail], acc) do
    case Integer.parse(head) do
      {num, _rest} -> do_parse_args(tail, [num | acc])
      :error -> {:error, {:nan, head}}
    end
  end

  defp do_parse_args([], acc), do: {:ok, Enum.reverse(acc)}

  def run do
    System.argv()
    |> parse_args()
    |> case do
      {:ok, numbers} ->
        numbers
        |> quicksort()
        |> IO.inspect()

      {:error, :no_args} ->
        IO.puts("usage: air12.exs <numbers...>")
        System.halt()

      {:error, {:nan, arg}} ->
        IO.puts("'#{arg}' is not a valid numbers")
        System.halt()
    end
  end
end

Exercice.run()

# defmodule Benchmark do
#   def measure(context, fun) do
#     {time_in_microseconds, result} = :timer.tc(fun)
#     IO.puts("#{context} took #{time_in_microseconds / 100_000} seconds")
#     result
#   end
# end
#
# numbers = Enum.shuffle(for i <- 1..5_000_000, do: i)
#
# Benchmark.measure("Exercice.quicksort", fn ->
#   Exercice.quicksort(numbers)
# end)
#
# Benchmark.measure("Enum.sort", fn ->
#   Enum.sort(numbers)
# end)
