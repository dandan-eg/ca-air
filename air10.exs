# Pyramide
defmodule Exercice do
  def run do
    System.argv()
    |> validate_args()
    |> case do
      {:ok, letter, heigth} ->
        draw_pyramid(letter, heigth)

      {:error, :bad_args} ->
        IO.puts("Usage elixir air10.exs <letter> <heigth>")
        System.halt(1)

      {:error, :not_char} ->
        IO.puts("Please provide a valid letter")
        System.halt(1)

      {:error, :not_number} ->
        IO.puts("Please provide a number for the heigth")
        System.halt(1)

      {:error, :invalid_heigth} ->
        IO.puts("Heigth must be higher than 0")
        System.halt(1)
    end
  end

  def draw_pyramid(letter, heigth) do
    width = heigth * 2 - 1
    do_draw_pyramid(letter, width, heigth, heigth)
  end

  def do_draw_pyramid(_letter, _width, _heigth, 0), do: :ok

  def do_draw_pyramid(letter, width, heigth, floor) do
    start = floor
    limit = width - floor + 1

    to_display =
      Enum.map(1..width, fn
        i when i >= start and i <= limit -> letter
        _i -> " "
      end)

    IO.puts(to_display)

    do_draw_pyramid(letter, width, heigth, floor - 1)
  end

  @spec validate_args(list(String.t())) ::
          {:ok, String.t(), integer()}
          | {:error, :bad_args}
          | {:error, :not_number}
          | {:error, :not_char}
          | {:error, :invalid_heigth}

  def validate_args([maybe_char, maybe_number]) do
    with {:ok, char} <- validate_char(maybe_char),
         {:ok, heigth} <- validate_heigth(maybe_number) do
      {:ok, char, heigth}
    end
  end

  def validate_args(_args), do: {:error, :bad_args}

  defp validate_heigth(arg) do
    case Integer.parse(arg) do
      {heigth, _rest} when heigth > 0 -> {:ok, heigth}
      {_heigth, _rest} -> {:error, :invalid_heigth}
      :error -> {:error, :not_number}
    end
  end

  defp validate_char(<<char::utf8>>), do: {:ok, char}
  defp validate_char(_), do: {:error, :not_char}
end

Exercice.run()
