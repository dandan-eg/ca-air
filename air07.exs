# Insertion dans tableau trié
defmodule Exercice do
  def parse_args([]), do: {:error, :bad_args}

  def parse_args(args) do
    case do_parse_args(args, []) do
      {:ok, numbers} ->
        {to_insert, remaining_numbers} = List.pop_at(numbers, -1)

        if sorted?(remaining_numbers) do
          {:ok, remaining_numbers, to_insert}
        else
          {:error, :nonsorted}
        end

      {:error, _reason} = error ->
        error
    end
  end

  def do_parse_args([], acc), do: {:ok, Enum.reverse(acc)}

  def do_parse_args([head | tail], acc) do
    case Integer.parse(head) do
      :error -> {:error, {:nan, head}}
      {number, _rest} -> do_parse_args(tail, [number | acc])
    end
  end

  def sorted?([]), do: true
  def sorted?([_number]), do: true
  def sorted?([first | [second | _] = tail]) when first < second, do: sorted?(tail)
  def sorted?([first | [second | _]]) when first >= second, do: false

  def insert(numbers, to_insert) do
    do_insert(numbers, to_insert, [])
  end

  # [1 2 4], 3, []
  # [2 4], 3, [1]
  # [4], 3, [2, 1]
  # [], :inserted, [4, 3, 2, 1]
  def do_insert([], :inserted, acc), do: Enum.reverse(acc)
  def do_insert([], to_insert, acc), do: Enum.reverse([to_insert | acc])
  def do_insert([head | tail], :inserted, acc), do: do_insert(tail, :inserted, [head | acc])

  def do_insert([head | tail], to_insert, acc) when head < to_insert,
    do: do_insert(tail, to_insert, [head | acc])

  def do_insert([head | tail], to_insert, acc),
    do: do_insert(tail, :inserted, [head, to_insert | acc])

  def run do
    System.argv()
    |> Exercice.parse_args()
    |> case do
      {:ok, numbers, to_insert} ->
        numbers
        |> Exercice.insert(to_insert)
        |> IO.inspect()

      {:error, {:nan, arg}} ->
        IO.puts("#{arg} is not a valid number")
        System.halt(1)

      {:error, :nonsorted} ->
        IO.puts("please provide sorted numbers")
        System.halt(1)

      {:error, :bad_args} ->
        IO.puts("usage: elixir eau07.exs <number1> <number2> ..")
        System.halt(1)
    end
  end
end

Exercice.run()
