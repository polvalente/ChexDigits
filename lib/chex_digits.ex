defmodule ChexDigits do
  @moduledoc """
  This is the main module for the library.
  """
  import ChexDigits.Rules, only: [check_digit: 2]
  @spec gen_check_digit(String.t(), Atom.t()) :: List.t()
  def gen_check_digit(digits, type) do
    check_digit(digits, type)
  end
end
