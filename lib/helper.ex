defmodule DigitValidator.Helper do
  def checksum(digits, m, weights \\ 1, replacements \\ %{}) do
    digits
    |> dot(weights)
    |> Enum.sum()
    |> mod(m, replacements)
  end

  def mod(digit, m, replacements \\ %{}) do
    case Map.get(replacements, digit) do
      nil ->
        m - rem(digit, m)
      val ->
        val
    end
  end

  def dot(u, v) when is_list(u) and is_list(v) do
    [u, v]
    |> List.zip()
    |> Enum.reduce(
      0,
      fn({a, b}, acc) ->
        acc + a*b
      end
    )
  end

  def dot(u, v) when is_number(u) and is_list(v),
    do: Enum.map(v, &(&1 * u))

  def dot(u, v) when is_number(v) and is_list(u),
    do: Enum.map(u, &(&1 * v))
end