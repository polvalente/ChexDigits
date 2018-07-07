defmodule ChexDigits.Rules.CreditCard do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(digits) do
    Rule.new(
      digits,
      nil,
      nil,
      nil,
      H.two_one(length(digits)),
      H.replacements(%{}, %{}),
      9
    )
  end

  def execute(rule) do
    rule
    |> H.checksum()
    |> H.to_next_multiple_of(10)
  end
end
