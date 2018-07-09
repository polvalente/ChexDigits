defmodule ChexDigits do
  @moduledoc """
  This is the main module for the library.
  """
  alias ChexDigits.Rules
  @spec gen_check_digit(String.t(), Atom.t()) :: List.t()
  def gen_check_digit(digits, type) do
    Rules.check_digit(digits, type)
  end

  def check_digit(digits, type) when is_binary(digits) do
    [digit1, digit2] = Rules.check_digit(digits, type)
    String.slice(digits, -2..-1) == "#{digit1}#{digit2}"
  end

  def check_digit(agency, account, bank)
      when is_binary(agency) and is_binary(account) do
    digit = Rules.check_digit(agency, account, bank)
    String.last(account) == "#{digit}"
  end
end
