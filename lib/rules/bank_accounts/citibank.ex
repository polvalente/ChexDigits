defmodule ChexDigits.Rules.BankAccounts.Citibank do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(account, _agency) do
    Rule.new(
      H.to_list(account),
      %{},
      %{11 => 0, 10 => 0},
      11,
      :module_minus,
      to_list(11..2)
    )
  end

  def execute(rule), do: H.checksum(rule)
end
