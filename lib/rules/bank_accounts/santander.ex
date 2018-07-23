defmodule ChexDigits.Rules.BankAccounts.Santander do
  @moduledoc false
  # alias ChexDigits.Types.Rule
  # alias ChexDigits.Helper, as: H

  # def rule(account, agency) do
  #   Rule.new(
  #     H.to_list(agency) ++ H.pad(H.to_list(account), 10, :left),
  #     14,
  #     :left,
  #     -10,
  #     [9, 7, 3, 1, 0, 0, 9, 7, 1, 3, 1, 9, 7, 3],
  #     H.replacements(%{0 => 0}, %{})
  #   )
  # end

  # def execute(rule), do: H.checksum(rule)
end
