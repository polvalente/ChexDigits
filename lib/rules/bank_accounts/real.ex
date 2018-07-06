defmodule ChexDigits.Rules.BankAccounts.Real do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H

  def rule(account, agency) do
    Rule.new(
      H.to_list(agency) ++ H.to_list(account),
      11,
      :left,
      -11,
      [8, 1, 4, 7, 2, 2, 5, 9, 3, 9, 5],
      H.replacements(%{1 => 0, 0 => 1}, %{})
    )
  end

  def execute(rule), do: H.checksum(rule)
end
