defmodule ChexDigits.Rules.BankAccounts.Itau do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H

  def rule(account, agency) do
    Rule.new(
      H.to_list(agency) ++ H.to_list(account),
      9,
      :left,
      -10,
      H.two_one(9),
      H.replacements(%{0 => 0}, %{}),
      9
    )
  end

  def execute(rule), do: H.checksum(rule)
end
