# Chercher l'intrus
defmodule Exercice do
  def find_unique(list) do
    find_unique_with_memo(list, %{})
  end

  def find_unique_with_memo([head | tail], memo) do
    cond do
      memo[head] ->
        find_unique(tail, memo)

      not unique?(head) ->
        find_unique(tail, MapSet.put(memo, head))

      true ->
        head
    end
  end

  def find_unique_with_memo([], _memo), do: nil

  def unique?(target, [target | _]), do: false
  def unique?(_target, []), do: true
  def unique?(target, [_ | tail]), do: unique?(target, tail)

  def display_result(nil), do: IO.puts("Aucun intrus")
  def display_result(found), do: IO.puts("l'intrus est #{found}")
end

case System.argv() do
  [] ->
    IO.puts("usage: elixir air02.exs <args..>")

  args ->
    args
    |> Exercice.find_unique()
    |> Exercice.display_result()
end
