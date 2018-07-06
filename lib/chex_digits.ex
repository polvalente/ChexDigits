defmodule ChexDigits do
  @moduledoc """
  This is the main module for the library.
  """
  import ChexDigits.Rules, only: [check_digit: 2]
  @spec gen_check_digit(String.t(), Atom.t()) :: List.t()
  def gen_check_digit(digits, type) do
    digits
    |> String.split("", trim: true)
    |> Enum.filter(fn digit -> Regex.match?(~r/[0-9]/, digit) end)
    |> Enum.map(&String.to_integer/1)
    |> check_digit(type)
  end
end
