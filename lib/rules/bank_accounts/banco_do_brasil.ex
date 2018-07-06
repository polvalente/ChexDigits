defmodule ChexDigits.Rules.BankAccounts.BancoDoBrasil do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(account, _agency) do
    Rule.new(
      account,
      8,
      :left,
      -11,
      to_list(9..2),
      H.replacements(%{}, %{10 => "X", 11 => 0})
    )
  end

  def execute(rule), do: H.checksum(rule)
end
