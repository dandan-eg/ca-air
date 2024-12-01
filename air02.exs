# Chercher l'intrus
defmodule Exercice do
  def find_unique(list) do
    find_unique_with_memo(list, MapSet.new())
  end

  def find_unique_with_memo([head | tail], memo) do
    cond do
      MapSet.member?(memo, head) ->
        find_unique_with_memo(tail, memo)

      not unique?(head, tail) ->
        find_unique_with_memo(tail, MapSet.put(memo, head))

      true ->
        head
    end
  end

  def find_unique_with_memo([], _memo), do: nil

  def unique?(target, [target | _]), do: false
  def unique?(_target, []), do: true
  def unique?(target, [_ | tail]), do: unique?(target, tail)

  def display_result(nil), do: IO.inspect("Aucun intrus")
  def display_result(found), do: IO.inspect("l'intrus est #{found}")

  def run do
    case System.argv() do
      [] ->
        IO.puts("usage: elixir air02.exs <args..>")
        System.halt(1)

      args ->
        args
        |> Exercice.find_unique()
        |> Exercice.display_result()
    end
  end
end

Exercice.run()
