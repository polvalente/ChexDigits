defmodule ChexDigits.Rules.BankAccounts.CaixaEconomica do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(account, agency) do
    Rule.new(
      H.to_list(agency) ++ H.to_list(account),
      15,
      :left,
      -11,
      to_list(8..2) ++ to_list(9..2),
      H.replacements(%{0 => 0}, %{10 => 0})
    )
  end

  def execute(rule), do: H.checksum(rule)
end
