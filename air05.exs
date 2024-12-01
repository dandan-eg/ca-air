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
    case Integer.parse(arg) do
      {number, _rest} -> do_parse_args(tail, [number | acc])
      :error -> {:error, {:nan, arg}}
    end
  end

  def run do
    System.argv()
    |> Exercice.parse_args()
    |> case do
      {:ok, mapper, numbers} ->
        numbers
        |> Enum.map(&(&1 + mapper))
        |> IO.inspect()

      {:error, {:nan, arg}} ->
        IO.puts("#{arg} is not a valid number")
        System.halt(1)

      {:error, :bad_args} ->
        IO.puts("usage: elixir eau05.exs <numbers..> <apply>")
        System.halt(1)
    end
  end
end

Exercice.run()
