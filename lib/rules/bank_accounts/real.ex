defmodule ChexDigits.Rules.BankAccounts.Real do
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(11, :left)
    |> checksum(
      -11,
      [8,1,4,7,2,2,5,9,3,9,5],
      replacements(%{1 => 0, 0 => 1}, %{})
    )
    |> List.wrap()
  end
end