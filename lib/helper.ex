defmodule ChexDigits.Helper do
  @moduledoc """
  This module contains all helper functions to specify the algorithms for checking digit calculation.

  The main function is `checksum`, which adds a lot of flexibility to the generic algorithm:
    1 - add all digits, each multiplied by its respective weight
    2 - calculate a remainder, which may or may not be subtracted from the module itself (e.g. 11 - mod(x, 11))
  """

  @doc """
  `checksum(digits, module, weights, replacements, weighted_sum_term_function)`

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

  `weighted_sum_term_function`:
    An optional argument that specifies if each step of the weighted sum will suffer an operation. The operation will be the given function.
  """

  alias ChexDigits.Types.Rule

  @spec checksum(%Rule{}) :: integer | String.t()
  def checksum(%Rule{
        digits: digits,
        input_alphabet: input_alphabet,
        output_alphabet: output_alphabet,
        module: module,
        module_type: module_type,
        weights: weights,
        weight_alignment: weight_alignment,
        per_term_function: per_term_function
      }) do
    digits
    |> map_onto(input_alphabet)
    |> dot(weights, per_term_function, weight_alignment)

    # |> mod(module, replacements)
  end

  @doc """
  This function performs the dot-product `u . v`.
  It aligns `v` over `u` depending on `alignment`.

  `v` is always zero-padded to have the same length as `u`.\n
  For example:\n
  `u = [1, 2, 3, 4]`\n
  `v = [1, 2]`\n
  `alignment = :right`\n
  is the same as:\n
  `u = [1, 2, 3, 4]`\n
  `v = [0, 0, 1, 2]`\n
  `alignment = :left`\n

  For each multiplication term, the function `fun/1` is applied afterwards.
  It is assumed that length(u) >= length(v)
  """

  # DOT
  def dot(u, v, fun, alignment) do
    direction =
      case alignment do
        :left ->
          1

        :right ->
          -1
      end

    u
    |> Enum.take(direction * length(v))
    |> Enum.zip(v)
    |> Enum.reduce(0, fn {x, y}, acc ->
      fun.(x * y) + acc
    end)
  end

  # MAP ONTO

  @doc """
  Performs the replacements specified by `alphabet` on `digits`
  If a given `digit` is not in the `alphabet`, it is returned unchanged.
  """
  @spec map_onto(list, Map.t()) :: list
  def map_onto(digits, alphabet) do
    digits
    |> Enum.map(fn digit ->
      if Map.has_key?(alphabet, digit) do
        Map.get(alphabet, digit)
      else
        digit
      end
    end)
  end

  # TO LIST
  def to_list(l) when is_binary(l) do
    l
    |> String.split("", trim: true)
    |> Enum.filter(fn digit -> Regex.match?(~r/[0-9]/, digit) end)
    |> Enum.map(&String.to_integer/1)
  end

  def to_list(l) when is_list(l), do: l
  def to_list(value), do: {:error, {:invalid_value, value}}
end
