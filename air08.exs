# Mélanger deux tableau trié
defmodule Exercice do
  def run do
    System.argv()
    |> split_args([])
    |> case do
      :error ->
        IO.puts("usage: elixir <numbers..> fusion <numbers..>")
        System.halt(1)

      {:ok, [], _second} ->
        IO.puts("missing arguments before 'fusion'")
        System.halt(1)

      {:ok, _first, []} ->
        IO.puts("missing arguments after 'fusion'")
        System.halt(1)

      {:ok, first, second} ->
        with {:ok, first_numbers} <- parse_args(first),
             {:ok, second_numbers} <- parse_args(second),
             :ok <- validate_sorted(first_numbers, second_numbers) do
          merged = merge(first_numbers, second_numbers)
          IO.inspect(merged)
        else
          {:error, :not_sorted} ->
            IO.puts("provide sorted numbers")
            System.halt(1)

          {:error, {:nan, invalid_arg}} ->
            IO.puts("'#{invalid_arg}' is not a valid number.")
            System.halt(1)
        end
    end
  end

  def parse_args(args), do: do_parse_args(args, [])

  defp do_parse_args([], acc), do: {:ok, Enum.reverse(acc)}

  defp do_parse_args([arg | tail], acc) do
    case Integer.parse(arg) do
      {num, _rest} -> do_parse_args(tail, [num | acc])
      :error -> {:error, {:nan, arg}}
    end
  end

  def sorted?([]), do: true
  def sorted?([_]), do: true
  def sorted?([first, second | _]) when first > second, do: false
  def sorted?([_ | tail]), do: sorted?(tail)

  def validate_sorted(first_numbers, second_numbers) do
    if sorted?(first_numbers) && sorted?(second_numbers) do
      :ok
    else
      {:error, :not_sorted}
    end
  end

  def split_args(["fusion" | tail], acc), do: {:ok, Enum.reverse(acc), tail}
  def split_args([arg | tail], acc), do: split_args(tail, [arg | acc])
  def split_args([], _acc), do: :error

  def merge(first_list, second_list) do
    do_merge(first_list, second_list, [])
  end

  defp do_merge([head | tail], [], acc), do: do_merge(tail, [], [head | acc])
  defp do_merge([], [head | tail], acc), do: do_merge(tail, [], [head | acc])
  defp do_merge([], [], acc), do: Enum.reverse(acc)

  defp do_merge(first_numbers, second_numbers, acc) do
    first_head = hd(first_numbers)
    second_head = hd(second_numbers)

    if first_head < second_head do
      do_merge(tl(first_numbers), second_numbers, [first_head | acc])
    else
      do_merge(first_numbers, tl(second_numbers), [second_head | acc])
    end
  end
end

Exercice.run()
