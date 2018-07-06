defmodule ChexDigits.Rules.BankAccounts.Banrisul do
  @moduledoc false
  import ChexDigits.Helper, only: [to_list: 1]
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(9, :left)
    |> checksum(
      -11,
      [3, 2, 4] ++ to_list(7..2),
      replacements(%{0 => 0, 1 => 6}, %{10 => 0})
    )
    |> List.wrap()
  end

  def rule(account, agency) do
    Rule.new(to_list(agency) ++ to_list(account))
  end
end
