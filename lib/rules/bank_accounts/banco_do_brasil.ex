defmodule ChexDigits.Rules.BankAccounts.BancoDoBrasil do
  @moduledoc false
  import ChexDigits.Helper, only: [replacements: 2, checksum: 1]
  import Enum, only: [to_list: 1]
  alias ChexDigits.Types.Rule

  def rule(account, agency \\ nil) do
    Rule.new(account, 8, :left, -11, to_list(9..2), replacements(%{}, %{10 => "X", 11 => 0}))
  end

  def execute(rule), do: checksum(rule)
end
