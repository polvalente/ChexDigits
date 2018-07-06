defmodule ChexDigits.Rules.BankAccounts.Bradesco do
  @moduledoc false
  alias ChexDigits.Types.Rule
  import ChexDigits.Helper, only: [replacements: 2, checksum: 1]
  import Enum, only: [to_list: 1]

  def rule(account, _agency) do
    Rule.new(
      account,
      8,
      :left,
      -11,
      [3, 2] ++ to_list(7..2),
      replacements(%{0 => 0, 1 => "P"}, %{})
    )
  end

  def execute(rule), do: checksum(rule)
end
