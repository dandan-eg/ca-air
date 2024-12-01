# Afficher le contenue d'un fichier
defmodule Exercice do
  def run do
    case System.argv() do
      [filename] ->
        case File.read(filename) do
          {:ok, binary} -> IO.puts(binary)
          {:error, reason} -> IO.puts("error: #{reason}")
        end

      _args ->
        IO.puts("usage: Elixir")
    end
  end
end

Exercice.run()
