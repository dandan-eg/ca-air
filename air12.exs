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
end

defmodule Benchmark do
  def measure(context, fun) do
    {time_in_microseconds, result} = :timer.tc(fun)
    IO.puts("#{context} took #{time_in_microseconds / 100_000} seconds")
    result
  end
end

numbers = Enum.shuffle(for i <- 1..5_000_000, do: i)

Benchmark.measure("Exercice.quicksort", fn ->
  Exercice.quicksort(numbers)
end)

Benchmark.measure("Enum.sort", fn ->
  Enum.sort(numbers)
end)
