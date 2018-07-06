defmodule ChexDigits.Rules.BankAccounts.Banrisul do
  import ChexDigits.Helper
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
end