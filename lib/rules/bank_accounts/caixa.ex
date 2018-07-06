defmodule ChexDigits.Rules.BankAccounts.CaixaEconomica do
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(15, :left)
    |> checksum(
      -11,
      to_list(8..2) ++ to_list(9..2),
      replacements(%{}, %{10 => 0})
    )
  end
end