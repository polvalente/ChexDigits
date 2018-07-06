defmodule ChexDigits.Rules.BankAccounts.Banrisul do
  @moduledoc false
  import ChexDigits.Helper, only: [replacements: 2, checksum: 1]
  import Enum, only: [to_list: 1]

  def rule(account, _agency) do
    Rule.new(
      account,
      9,
      :left,
      -11,
      [3, 2, 4] ++ to_list(7..2),
      replacements(%{0 => 0, 1 => 6}, %{10 => 0})
    )
  end

  def execute(rule), do: checksum(rule)
end
