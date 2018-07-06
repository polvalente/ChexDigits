defmodule ChexDigits.Helper do
  @moduledoc """
  This module contains all helper functions to specify the algorithms for checking digit calculation.

  The main function is `checksum`, which adds a lot of flexibility to the generic algorithm:
    1 - add all digits, each multiplied by its respective weight
    2 - calculate a remainder, which may or may not be subtracted from the module itself (e.g. 11 - mod(x, 11))
  """

  @doc """
  `checksum(digits, module, weights, replacements, weighted_sum_module)`

  `digits`: a List of digits for which the checksum will be calculated

  `module`: the module to calculate the final remainder.
    If `nil`, the number will be returned untouched
    If negative, the remainder will be: `abs(module) - rem(number, abs(module))`

  `weights`:
    An optional argument to perform a weighted sum on the digits

  `replacements`:
    An optional argument to specify a translation table (e.g. if the final result is 5, replace with "X").
    There should be a "before" and an "after" fields, each of which
    specify when the replacement will be applied -- before or after the `module - rem(digit, module)` calculation

    The `Helper.replacements/2` function build this map from two separate maps, for ease of use

    Example:
    %{
      "before" => %{0 => "X"},
      "after" => %{4 => "Y"}
    }

  `weighted_sum_module`:
    An optional argument that specifies if each step of the weighted sum will suffer a remainder operation. Behaves the same as `module`
  """
  @spec checksum(List.t(), integer | nil, List.t(), Map.t(), integer | nil) :: any()
  def checksum(digits, module, weights \\ 1, replacements \\ %{}, weighted_sum_module \\ nil) do
    digits
    |> dot(weights, weighted_sum_module)
    |> mod(module, replacements)
  end

  def replacements(before_replacements \\ %{}, after_replacements \\ %{}) do
    %{
      "after" => after_replacements,
      "before" => before_replacements
    }
  end

  def mod(digit, module, %{"after" => after_replacements, "before" => before_replacements}) do
    r = my_rem(digit, abs(module))

    case Map.get(before_replacements, r) do
      nil ->
        replace(my_rem(digit, module), after_replacements)
      val ->
        val
    end
  end

  def replace(value, replacements) do
    case Map.get(replacements, value) do
      nil ->
        value
      replaced ->
        replaced
    end
  end

  def dot(u, v, module) when is_list(u) and is_list(v) do
    [u, v]
    |> List.zip()
    |> Enum.reduce(
      0,
      fn({a, b}, acc) ->
        acc + my_rem(a*b, module)
      end
    )
  end

  def dot(u, v, module) when is_number(u) and is_list(v),
    do: Enum.map(v, &(my_rem(&1 * u, module)))

  def dot(u, v, module) when is_number(v) and is_list(u),
    do: Enum.map(u, &(my_rem(&1 * v, module)))

  def two_one(length) do
    1..length
    |> Enum.map(&(rem(&1, 2) + 1))
  end

  def my_rem(n, nil), do: n
  def my_rem(n, module) when module < 0 do
    -module - rem(n, module)
  end
  def my_rem(n, module) do
    rem(n, module)
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

  def pad(digits, max_len, :right) when length(digits) < max_len, do: pad([0] ++ digits, max_len, :right)
  def pad(digits, max_len, :right) when length(digits) == max_len, do: digits
  def pad(_digits, max_len, :right), do: raise(ArgumentError, message: "Needs at most #{max_len} digits")
  def pad(digits, max_len, :left) when length(digits) < max_len, do: pad([0] ++ digits, max_len, :left)
  def pad(digits, max_len, :left) when length(digits) == max_len, do: digits
  def pad(_digits, max_len, :left), do: raise(ArgumentError, message: "Needs at most #{max_len} digits")
end