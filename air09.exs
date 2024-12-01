# Rotation vers la gauche
defmodule Exercice do
  def run do
    case System.argv() do
      [] ->
        IO.puts("usage: elixir eau09.exs <args..>")

      args ->
        args
        |> rotate()
        |> IO.inspect()
    end
  end

  def rotate([]), do: []

  def rotate([head | tail]) do
    append(tail, head, [])
  end

  def append([], to_append, acc), do: Enum.reverse([to_append | acc])
  def append([head | tail], to_append, acc), do: append(tail, to_append, [head | acc])
end

Exercice.run()
