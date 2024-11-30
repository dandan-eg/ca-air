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

      {:error, :not_letter} ->
        IO.puts("Please provide a valid letter")

      {:error, :not_number} ->
        IO.puts("Please provide a number for the heigth")

      {:error, :invalid_heigth} ->
        IO.puts("Heigth must be higher than 0")
    end
  end

  def draw_pyramid(letter, heigth) do
    width = heigth * 2 - 1
    do_draw_pyramid(letter, width, heigth, 0)
  end

  def do_draw_pyramid(_letter, _width, heigth, heigth), do: :ok

  def do_draw_pyramid(letter, width, heigth, floor) do
    start = heigth - floor
    limit = heigth + floor

    1..width
    |> Enum.map(fn
      i when i >= start and i <= limit ->
        letter

      _i ->
        " "
    end)
    |> IO.puts()

    do_draw_pyramid(letter, width, heigth, floor + 1)
  end

  @spec validate_args(list(String.t())) ::
          {:ok, String.t(), integer()}
          | {:error, :bad_args}
          | {:error, :not_number}
          | {:error, :not_letter}
          | {:error, :invalid_heigth}

  def validate_args([letter, maybe_number]) do
    with :ok <- validate_letter(letter),
         {:ok, heigth} <- validate_heigth(maybe_number) do
      {:ok, letter, heigth}
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

  defp validate_letter(arg) do
    if byte_size(arg) === 1,
      do: :ok,
      else: {:error, :not_letter}
  end
end

Exercice.run()
