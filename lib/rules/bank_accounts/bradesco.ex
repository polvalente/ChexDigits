defmodule ChexDigits.Rules.BankAccounts.Bradesco do
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(8, :left)
    |> checksum(
      -11,
      [3, 2] ++ to_list(7..2),
      replacements(%{0 => 0, 1 => "P"}, %{})
    )
    |> List.wrap()
  end
end