defmodule CheckDigit do
  @spec validate(String.t(), Atom.t()) :: List.t()
  def validate(digits, type) do
    digits
    |> String.split("", trim: true)
    |> Enum.filter(fn digit -> Regex.match?(~r/[0-9]/, digit) end)
    |> Enum.map(&String.to_integer/1)
    |> CheckDigit.Rules.verifier_digit(type)
  end
end
