defmodule ChexDigits.Types.Rule do
  @moduledoc """
  `%Rule{
    length: non_neg_integer,
    padding: :left | :right,
    digits: List.t(),
    module: integer | nil,
    weights: List.t(),
    replacements: Map.t(),
    weighted_sum_module: integer | nil
  }`

  `length`: the expected length for `digits`
  `padding`: if length(`digits`) < `length`, `digits` will be
            zero-padded from the left or from the right, according to this parameter
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

    Example: %{
      "before" => %{0 => "X"},
      "after" => %{4 => "Y"}
    }

  `weighted_sum_module`:
    An optional argument that specifies if each step of the weighted sum will suffer a remainder operation. Behaves the same as `module`
  """

  import Exchema.Notation
  alias ChexDigits.Helper, as: H
  alias Exchema.Types, as: EXT
  alias ChexDigits.Types, as: CDT

  structure(
    length: EXT.Integer.NonNegative,
    padding: CDT.Padding,
    digits: EXT.List,
    module: {EXT.Optional, EXT.Integer},
    weights: EXT.List,
    replacements: CDT.Replacements,
    weighted_sum_module: {EXT.Optional, EXT.Integer}
  )

  @spec new(
          non_neg_integer,
          atom,
          List.t() | String.t(),
          integer,
          List.t() | String.t(),
          Map.t(),
          integer
        ) :: %__MODULE__{}
  def new(
        digits,
        length,
        padding,
        module,
        weights,
        replacements \\ %{before: %{}, after: %{}},
        weighted_sum_module \\ nil
      ) do
    with digits <- H.to_list(digits),
         weights <- H.to_list(weights) do
      rule = %__MODULE__{
        digits: digits,
        length: length,
        padding: padding,
        module: module,
        weights: weights,
        replacements: replacements,
        weighted_sum_module: weighted_sum_module
      }

      case Exchema.errors(rule, __MODULE__) do
        [] -> rule
        errors -> raise Exchema.flatten_errors(errors)
      end
    end
  end
end
