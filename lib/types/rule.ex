defmodule ChexDigits.Types.Rule do
  @moduledoc """
  `%Rule{
    digits: list,
    input_alphabet: list,
    output_alphabet: list,
    module: integer | nil,
    module_type: atom,
    weights: list | non_neg_integer,
    weight_alignment: atom,
    per_term_function: function
  }`

  `digits`: a List of digits for which the checksum will be calculated

  `module`: the module to calculate the final remainder.
    If `nil`, the number will be returned untouched

  `module_type`: one of:
    - `:standard`: the checksum module will be: `rem(sum, module)`
    - `:module_minus`: the checksum module will be: `module - rem(sum, module)`

  `weights`:
    The enumerable that contains the weights to be used when calculating the checksum.
    Can also be a number.

  For `input_alphabet` and `output_alphabet`, if the digit is not specified, itself is returned
  `input_alphabet`:
    A map that translates the `digits` list into a numerical representation
    e.g.: %{"0" => 0, "1" => 1, "X" => 10}
  `output_alphabet`:
    A map that translates the calculated check digit into a string representation:
    e.g.:
      check_digit = 11 - rem(1 * 7 + 2 * 6 + 3 * 5, 11)
      # Here, check_digit == 10. However, it we need the results to conform to a single character.
      # Therefore, we use the folowing output_alphabet, which maps every digit 0 - 9 onto its character
      # and the number `10` is mapped onto the character `"X"`.
      output_alphabet = %{10 => "X"}

  `per_term_function`:
    An optional argument that specifies the function to be applied to the result of each multiplication in the weighted sum.
  """

  alias ChexDigits.Helper, as: H

  defstruct [
    :digits,
    :input_alphabet,
    :output_alphabet,
    :module,
    :module_type,
    :weights,
    :weight_alignment,
    :per_term_function
  ]

  @spec new(
          List.t() | String.t(),
          Map.t(),
          Map.t(),
          non_neg_integer,
          atom,
          List.t() | non_neg_integer,
          atom,
          function
        ) :: %__MODULE__{}
  def new(
        digits,
        input_alphabet,
        output_alphabet,
        module,
        module_type,
        weights,
        weight_alignment \\ :right,
        per_term_function \\ & &1
      ) do
    with digits <- H.to_list(digits),
         weights <- H.to_list(weights) do
      %__MODULE__{
        digits: digits,
        input_alphabet: input_alphabet,
        output_alphabet: output_alphabet,
        module: module,
        module_type: module_type,
        weights: weights,
        weight_alignment: weight_alignment,
        per_term_function: per_term_function
      }
    end
  end
end
