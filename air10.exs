# Pyramide
defmodule Exercice do
  def run do
    System.argv()
    |> validate_args()
    |> case do
      {:ok, letter, heigth} ->
        draw_pyramid(letter, heigth)

      {:error, reason} ->
        IO.puts(reason)
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

  def validate_args([letter, maybe_number]) do
    with :ok <- validate_letter(letter),
         {:ok, heigth} <- validate_number(maybe_number) do
      {:ok, letter, heigth}
    end
  end

  def validate_args(_args), do: {:error, :bad_args}

  defp validate_number(arg) do
    case Integer.parse(arg) do
      {num, _rest} -> {:ok, num}
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
