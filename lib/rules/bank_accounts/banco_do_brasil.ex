defmodule ChexDigits.Rules.BankAccounts.BancoDoBrasil do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(account, _agency) do
    Rule.new(
      account,
      %{},
      %{10 => X, 11 => 0},
      11,
      :module_minus,
      to_list(9..2)
    )
  end

  def execute(rule), do: H.checksum(rule)
end
