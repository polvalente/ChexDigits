defmodule DigitValidator.Helper do
  def checksum(digits, m, weights \\ 1, replacements \\ %{}, dot_mod \\ nil) do
    digits
    |> dot(weights, dot_mod)
    |> mod(m, replacements)
  end

  def mod(digit, m, replacements \\ %{}) do
    r = my_rem(digit, m)

    case Map.get(replacements, r)do
      nil ->
        r
      val ->
        val
    end
  end

  def dot(u, v, m) when is_list(u) and is_list(v) do
    [u, v]
    |> List.zip()
    |> Enum.reduce(
      0,
      fn({a, b}, acc) ->
        acc + my_rem(a*b, m)
      end
    )
  end

  def dot(u, v, m) when is_number(u) and is_list(v),
    do: Enum.map(v, &(my_rem(&1 * u, m)))

  def dot(u, v, m) when is_number(v) and is_list(u),
    do: Enum.map(u, &(my_rem(&1 * v, m)))

  def two_one(length) do
    1..length
    |> Enum.map(&(rem(&1, 2) + 1))
  end

  defp my_rem(n, nil), do: n
  defp my_rem(n, m) when m < 0 do
    -m - rem(n, -m)
  end
  defp my_rem(n, m) do
    rem(n, m)
  end

  def to_next_multiple_of(vd, n) do
    case rem(vd, n) do
      0 ->
        0
      _ ->
        (div(vd, n) + 1) * n - vd
    end
  end

  def sub(u, v) when is_list(u) and is_list(v) do
    [u, v]
    |> List.zip()
    |> Enum.map(fn {a, b} -> a - b end)
  end

  def sub(u, v) when is_number(u) and is_list(v),
    do: Enum.map(v, &(u - &1))

  def sub(u, v) when is_number(v) and is_list(u),
    do: Enum.map(u, &(v - &1))
end