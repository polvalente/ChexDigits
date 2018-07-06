defmodule ChexDigits.Rules.BankAccounts.Santander do
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(14, :left)
    |> checksum(
      -10,
      [9,7,3,1,0,0,9,7,1,3,1,9,7,3],
      replacements(%{0 => 0}, %{})
    )
    |> List.wrap()
  end
end