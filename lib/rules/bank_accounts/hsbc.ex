defmodule ChexDigits.Rules.BankAccounts.HSBC do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H

  def rule(account, agency) do
    Rule.new(
      H.to_list(agency) ++ H.pad(H.to_list(account), 6, :left),
      %{},
      %{11 => 0, 1 => 0},
      11,
      :standard,
      [8, 9, 2, 3, 4, 5, 6, 7, 8, 9]
    )
  end

  def execute(rule), do: H.checksum(rule)
end
