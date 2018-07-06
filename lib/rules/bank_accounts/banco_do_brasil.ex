defmodule ChexDigits.Rules.BankAccounts.BancoDoBrasil do
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(8, :left)
    |> checksum(
      -11,
      to_list(9..2),
      replacements(%{}, %{10 => "X", 11 => 0})
    )
    |> List.wrap()
  end
end